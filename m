Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6F0439E39
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 20:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhJYSPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 14:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbhJYSPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 14:15:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0958BC061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 11:13:14 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635185592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d5BfnmRBE1dbADgjyqjL7W1xnI7QDmOS8P/wOGhlMhQ=;
        b=Rs9sNID0/NSL4cpr8FfIZ7WC+/m8UbPT6v0JX7lNYWw7uKYHJy7RWULGuNfUYi9/iDGymL
        n2zOkekUkALnUM80/QJMUs6ixaN6xjZKdO9YzBRa2TDOVi/tGXVkC87WoY5uEU65h9Zy79
        DaO9H8Pr8UIkeYVLNo6+s0tmXr4VtdBR45e4jazO4FrWNwQNEmQf/5xxDIWjGVKW22RdR7
        4DLaHEoH2a9bjJTemMJ/xQQFAzWzcpwAWYiiaRtsMUcBrynmDu5vt6QIDxLG9vpS8veTgF
        Vc7WXf401Yz4gOM+iLfVfg/WoMJ5q2fVJRZYXJGBWY6bqFYSL9zUpv9VSFBUBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635185592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d5BfnmRBE1dbADgjyqjL7W1xnI7QDmOS8P/wOGhlMhQ=;
        b=Mig/Mx9G2Avw35R7QS3GIl9m/vQyMd7p8Y4GVYT2K6yQE5G37UGLkElfn43PCNk6zqy41I
        uWtIH+3ihEml6ZBQ==
To:     Mika =?utf-8?Q?Penttil=C3=A4?= <mika.penttila@nextfour.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, dave.hansen@linux.intel.com, arjan@linux.intel.com,
        ravi.v.shankar@intel.com
Subject: Re: [PATCH 15/23] x86/fpu: Add sanity checks for XFD
In-Reply-To: <20d31ed9-be3d-dca6-ceef-ced35f80d131@nextfour.com>
References: <20211021225527.10184-1-chang.seok.bae@intel.com>
 <20211021225527.10184-16-chang.seok.bae@intel.com>
 <20d31ed9-be3d-dca6-ceef-ced35f80d131@nextfour.com>
Date:   Mon, 25 Oct 2021 20:13:11 +0200
Message-ID: <87o87dezwo.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25 2021 at 11:33, Mika Penttil=C3=A4 wrote:
> On 22.10.2021 1.55, Chang S. Bae wrote:
>> +#ifdef CONFIG_X86_DEBUG_FPU
>> +/*
>> + * Ensure that a subsequent XSAVE* or XRSTOR* instruction with RFBM=3D@=
mask
>> + * can safely operate on the @fpstate buffer.
>> + */
>> +static bool xstate_op_valid(struct fpstate *fpstate, u64 mask, bool rst=
or)
>> +{
>> +	u64 xfd =3D __this_cpu_read(xfd_state);
>> +
>> +	if (fpstate->xfd =3D=3D xfd)
>> +		return true;
>> +
>> +	/* For current's fpstate the XFD state must be correct. */
>> +	if (fpstate->xfd =3D=3D current->thread.fpu.fpstate->xfd)
>> +		return false;
>> +
> Should this return true or is the comment confusing?

Comment might be confusing. The logic here is:

If fpstate->xfd equal xfd then it's valid.

So the next check is whether fpstate is the same as current's
fpstate. If that's the case then the result is invalid because for
current's fpstate the first condition should be true. But if it is not
true then the state is not valid.

Thanks,

        tglx
