Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6059357F22
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 11:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhDHJaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 05:30:07 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39998 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229600AbhDHJaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:30:06 -0400
Received: from zn.tnic (p200300ec2f095000c11580856fe05acf.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:5000:c115:8085:6fe0:5acf])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EB3E31EC0118;
        Thu,  8 Apr 2021 11:29:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1617874195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=DhcXDzG3v+JRKTfJzLqArnte0jON7pxSCO9ye+e6s9Y=;
        b=mqdetZzJ+8vl9yO0XdOLf3F+gFDLmZdrz3nSINeH1H5E+YOdZHqc6+wtEQcbhAkAdQ17Eb
        p///7dt0bRJkPBNkY1d4bLc5u28E+3ItvHObuhOd1BEMDZXrsRVSDUjJSeVZLgRTm+ydSV
        z446jDDQTKncqfh3mxVWoHQCpeWKIGw=
Date:   Thu, 8 Apr 2021 11:29:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-sgx@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] x86/sgx: Do not update sgx_nr_free_pages in
 sgx_setup_epc_section()
Message-ID: <20210408092952.GF10192@zn.tnic>
References: <20210405232653.33680-1-jarkko@kernel.org>
 <20210407154934.GF25319@zn.tnic>
 <YG3X454GI4U2BZVU@kernel.org>
 <20210407161811.GK25319@zn.tnic>
 <YG7DbunDoPocsEzZ@kernel.org>
 <20210408085640.GD10192@zn.tnic>
 <YG7LcLFKokoGzslp@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YG7LcLFKokoGzslp@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 12:22:56PM +0300, Jarkko Sakkinen wrote:
> They are not in the "free_page_list" before sanitization process has put
> them to there. So in that way the count is also better in sync with this
> fix.

This is the bit of information I was looking for. This needs to be in
the commit message.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
