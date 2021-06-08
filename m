Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175023A018F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 21:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236095AbhFHSyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 14:54:08 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42228 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235377AbhFHSsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 14:48:02 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 32944219D8;
        Tue,  8 Jun 2021 18:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623177968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sY1lNhT8zE/AvIyHCiemembHK2uoefGtSYoQxLprpo0=;
        b=WJpCMzacaMbZSPcKkJSmKUQOuYFB+R+axjR2eu77aFtqDXuSl8mh8X7NV8ge4zny3v+84b
        X7BumQxfoeAOW4G5rptqvX5dWb0V2hEn7+P9DzJ+MOKvGqCc3D8u6SQuM/1hM4TiVG4Hny
        ENHusJJquABxOwqMlfLmQFonkEo5+Oo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623177968;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sY1lNhT8zE/AvIyHCiemembHK2uoefGtSYoQxLprpo0=;
        b=qVoIvDLtc64ta6H3xXZa20TwkiE/+ffu+bvvIygUKdhUnAMNUa/QIDrGJD5FZFlY9XpIS7
        jlYkyemgMEHsO+Dg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 1E78C118DD;
        Tue,  8 Jun 2021 18:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623177968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sY1lNhT8zE/AvIyHCiemembHK2uoefGtSYoQxLprpo0=;
        b=WJpCMzacaMbZSPcKkJSmKUQOuYFB+R+axjR2eu77aFtqDXuSl8mh8X7NV8ge4zny3v+84b
        X7BumQxfoeAOW4G5rptqvX5dWb0V2hEn7+P9DzJ+MOKvGqCc3D8u6SQuM/1hM4TiVG4Hny
        ENHusJJquABxOwqMlfLmQFonkEo5+Oo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623177968;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sY1lNhT8zE/AvIyHCiemembHK2uoefGtSYoQxLprpo0=;
        b=qVoIvDLtc64ta6H3xXZa20TwkiE/+ffu+bvvIygUKdhUnAMNUa/QIDrGJD5FZFlY9XpIS7
        jlYkyemgMEHsO+Dg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 2ViiB/C6v2BJGAAALh3uQQ
        (envelope-from <bp@suse.de>); Tue, 08 Jun 2021 18:46:08 +0000
Date:   Tue, 8 Jun 2021 20:46:02 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        kernel test robot <rong.a.chen@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [tip:x86/cpu 4/4] Warning: Kernel ABI header at
 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at
 'arch/x86/include/asm/cpufeatures.h':  111< /* free                                    (
 3*32+29) */
Message-ID: <YL+66gKKW5CQjq5f@zn.tnic>
References: <20210602094153.GH1271937@shao2-debian>
 <YLdTRopUV9OyulSq@zn.tnic>
 <YLelUPtti40D7DUl@kernel.org>
 <YLlIsS1brAdNyG4K@zn.tnic>
 <YL+j2CfGJS40sPKM@kernel.org>
 <YL+rEhU4A1tXNFYO@zn.tnic>
 <YL+xwYq8LNLY6ePU@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YL+xwYq8LNLY6ePU@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 03:06:57PM -0300, Arnaldo Carvalho de Melo wrote:
> > Or, if we start doing that then they don't have to do anything.
> 
> Who? Previously its me doing this work, i.e. keeping things in synch.
> Actually it is expected that people doing the kernel work don't touch
> tools/ wrt adding the copy,

Ok, I think I'm totally confused. First you say that you're trying to
keep the headers in sync and now you say that patches adding stuff to
the kernel cpufeatures.h header should not touch the copy in tools/...

In any case, I was thinking that we could document what people touching
cpufeatures.h need to do and put it Documentation/x86/cpuinfo.rst.

And then spread the load by asking everyone to do that test and fix the
perf build accordingly.

So that you don't have to do it all by yourself.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
