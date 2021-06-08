Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C013C39FDE1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 19:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbhFHRk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 13:40:27 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38952 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbhFHRkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 13:40:25 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 90D74219AD;
        Tue,  8 Jun 2021 17:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623173911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ZYYnHSdL2Ejrdfcc93QIymDWZMhP6D0CegjSZ2K9MM=;
        b=NG/U/GMWxUCZI24h4Tv85IxOxhtrxLMUbz/GgjaEnYkPh+0zysfskrc9gJSSvLvpKugKm/
        R8N6idt5jGxmXWPUuX1HLFaR7GvMAHnlp5TSvGrwWDIux4bFxn/A2tghGH63VR5RlnawOP
        wRVlsGO9vc68QudrU2XeKYuYTkCmq5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623173911;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ZYYnHSdL2Ejrdfcc93QIymDWZMhP6D0CegjSZ2K9MM=;
        b=DiToVhtkyX3maP9hA6sXcmIWCIfCGua1hSBwSebiDK1EHy1fgCbD2mn95Lq+tanFq5fEEi
        eSY62BYyrxuiX3Ag==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 7E5AC118DD;
        Tue,  8 Jun 2021 17:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623173911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ZYYnHSdL2Ejrdfcc93QIymDWZMhP6D0CegjSZ2K9MM=;
        b=NG/U/GMWxUCZI24h4Tv85IxOxhtrxLMUbz/GgjaEnYkPh+0zysfskrc9gJSSvLvpKugKm/
        R8N6idt5jGxmXWPUuX1HLFaR7GvMAHnlp5TSvGrwWDIux4bFxn/A2tghGH63VR5RlnawOP
        wRVlsGO9vc68QudrU2XeKYuYTkCmq5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623173911;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ZYYnHSdL2Ejrdfcc93QIymDWZMhP6D0CegjSZ2K9MM=;
        b=DiToVhtkyX3maP9hA6sXcmIWCIfCGua1hSBwSebiDK1EHy1fgCbD2mn95Lq+tanFq5fEEi
        eSY62BYyrxuiX3Ag==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 85bRHRerv2AOdwAALh3uQQ
        (envelope-from <bp@suse.de>); Tue, 08 Jun 2021 17:38:31 +0000
Date:   Tue, 8 Jun 2021 19:38:26 +0200
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
Message-ID: <YL+rEhU4A1tXNFYO@zn.tnic>
References: <20210602094153.GH1271937@shao2-debian>
 <YLdTRopUV9OyulSq@zn.tnic>
 <YLelUPtti40D7DUl@kernel.org>
 <YLlIsS1brAdNyG4K@zn.tnic>
 <YL+j2CfGJS40sPKM@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YL+j2CfGJS40sPKM@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 02:07:36PM -0300, Arnaldo Carvalho de Melo wrote:
> Apply the patch, try to build it, it doesn't matter where you build it,
> only that after applying the patch I want to know if it doersn't build,
> so that I can look at it earlier than when it gets to my attention by
> merging upstream, etc.

I believe if you give the 0day guys a step-by-step what to do, they'll
probably add it to the lineup. :)

> We're doing it already, Peter wants to help me with it, and I think this
> has value.

Or, if we start doing that then they don't have to do anything.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
