Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF19320986
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 10:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhBUJpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 04:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbhBUJpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 04:45:21 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E725C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 01:44:38 -0800 (PST)
Received: from zn.tnic (p200300ec2f205c000e54e9bea7f0af0c.dip0.t-ipconnect.de [IPv6:2003:ec:2f20:5c00:e54:e9be:a7f0:af0c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 243AA1EC04D1;
        Sun, 21 Feb 2021 10:44:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1613900676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kPk+H/FJh1yelAqAId43tAJspx8AooMxmB85fJZPaZ4=;
        b=FfT8sleVclQg7vqmNFZNvBtWnDjl2SD+sv8/sy8k1TiO/3CRhmdb1XODLgEuOsNacWu/HQ
        aQdJ7bYi5H8Hq6z3sRzcKIUp8JRZiuU0nK87KrCSx/wZ9HM0JcG8p+jAJFXpzkawPpFHWY
        2xIGt1jUfQ9uA6+//s+GCStdPlxP/ko=
Date:   Sun, 21 Feb 2021 10:44:34 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        pjt@google.com, mbenes@suze.cz, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 6/6] objtool,x86: Rewrite retpoline thunk calls
Message-ID: <20210221094434.GA1897@zn.tnic>
References: <20210219204300.749932493@infradead.org>
 <20210219210535.492733466@infradead.org>
 <20210219215530.ivzzv3oavhuip6un@treble>
 <20210219220158.GD59023@worktop.programming.kicks-ass.net>
 <20210220003920.GG26778@zn.tnic>
 <YDE9bmaO4tOZ/HWn@hirez.programming.kicks-ass.net>
 <20210220174101.GA29905@zn.tnic>
 <20210220223221.GB4746@worktop.programming.kicks-ass.net>
 <1e498602-5319-6f12-b33e-d40a7735d316@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e498602-5319-6f12-b33e-d40a7735d316@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 21, 2021 at 06:45:54AM +0100, Jürgen Groß wrote:
> If you want I can cook up a patch and include it in my paravirt
> cleanup series.

Sure, Linus already pulled the first part of your cleanup so you can
base off the rest ontop.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
