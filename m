Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9129446233
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 11:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbhKEKeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 06:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbhKEKem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 06:34:42 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82F5C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 03:32:02 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id c8so14709595ede.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 03:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=forissier-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oSv7D1xIIC6anDf0PiS5TuhEoZ2nlQZDfkuMpmTafRY=;
        b=zSV2PpczbIyBSO8ggup2ToVxaJTGECSlsZtQSVGwi6EDfMmzAvUYJEJujLf99RakhK
         txv8A69joHczPfpOx0Zuygk3u99FAtFFC79TIrkTQo0rp6o8cshcV4du7XXt+IYJXaqz
         qWLggY/xXGUVktYWFqaTV1Tl1Blrwrvo947ib8zWZuQ3t6caTCINGN+lYdS68sCw5zeW
         C5bMSJU3AccQAQDTkO6p8JVNpmYFb0Vn0P9PEC0vBPcqkUrZQ6sJwcGJKAqjy6HMvJae
         3nLZe5XU8B/UBgTfTVr3iPs6pOY0He55s49JQRNfPmt/X0ChSWyw+lG0HM90MkfHF5x/
         gXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oSv7D1xIIC6anDf0PiS5TuhEoZ2nlQZDfkuMpmTafRY=;
        b=o7fdLe6rOJGKlh1fssML512GyEhKQTyIQ/BINFvfn5FG9MYtNvOOJwIoTX7hGYeQGz
         715YqfZQQsPxV0/FLTFaTcLogKMGOgPRdqp9X8d3/Jq/ZoCAlWkkf0j8OzSmlKHOvmlf
         i0QcStUbyrTAzufgHwdAH0fnMKZ2VdhciwKoNfvZk9Z3hCvmkWpOfezWYDUla66nTHVO
         NRzhQKFagsvC3qbaGw1YHSbxENkmB+MwqHrY2k8aBANCkyVsKRXnRm762iftPieSBYbz
         DUnpr/8OWZ56sKliz5IeOqAXlQ2qoa/KJFGVBTAzaMURbByZ9H+bBCWsWSSKTQgtDD2s
         IddQ==
X-Gm-Message-State: AOAM5327HUlp4C7kof95R1zRmqBUifXcKFRCvhmvNZOdSaSx3khzHnAP
        OVHkgphxeslIxWsDeVnZMptwsc4muhM8c8vxiMADtsqY
X-Google-Smtp-Source: ABdhPJyi7jRJRV6cYV7dsfukVymYMhwCh9CUXPWKrCp2JZY+/ZHLcPcx+G3KzTSCZPkYSy8sxeggaw==
X-Received: by 2002:a05:6402:518f:: with SMTP id q15mr10722234edd.77.1636108320522;
        Fri, 05 Nov 2021 03:32:00 -0700 (PDT)
Received: from [10.8.0.11] ([195.216.219.13])
        by smtp.gmail.com with ESMTPSA id g26sm3893071ejz.21.2021.11.05.03.31.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 03:32:00 -0700 (PDT)
Message-ID: <74572362-c45c-b10f-f825-2e8bb4e3b027@forissier.org>
Date:   Fri, 5 Nov 2021 11:31:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] checkpatch: relax regexp for COMMIT_LOG_LONG_LINE
Content-Language: en-US
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org
References: <20210923143842.2837983-1-jerome@forissier.org>
From:   Jerome Forissier <jerome@forissier.org>
In-Reply-To: <20210923143842.2837983-1-jerome@forissier.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/21 16:38, Jerome Forissier wrote:
> One exceptions to the COMMIT_LOG_LONG_LINE rule is a file path followed
> by :. That is typically some sort diagnostic message from a compiler or
> a build tool, in which case we don't want to wrap the lines but keep the
> message unmodified.
> The regular expression used to match this pattern currently doesn't
> accept absolute paths or + characters. This can result in false
> positives as in the following (out-of-tree) example:
> 
>   ...
>   /home/jerome/work/optee_repo_qemu/build/../toolchains/aarch32/bin/arm-linux-gnueabihf-ld.bfd: /home/jerome/work/toolchains-gcc10.2/aarch32/bin/../lib/gcc/arm-none-linux-gnueabihf/10.2.1/../../../../arm-none-linux-gnueabihf/lib/libstdc++.a(eh_alloc.o): in function `__cxa_allocate_exception':
>   /tmp/dgboter/bbs/build03--cen7x86_64/buildbot/cen7x86_64--arm-none-linux-gnueabihf/build/src/gcc/libstdc++-v3/libsupc++/eh_alloc.cc:284: undefined reference to `malloc'
>   ...
> 
> Update the regular expression to match the above paths.
> 
> Signed-off-by: Jerome Forissier <jerome@forissier.org>
> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index c27d2312cfc3..bf2094cb4271 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3147,7 +3147,7 @@ sub process {
>  		    length($line) > 75 &&
>  		    !($line =~ /^\s*[a-zA-Z0-9_\/\.]+\s+\|\s+\d+/ ||
>  					# file delta changes
> -		      $line =~ /^\s*(?:[\w\.\-]+\/)++[\w\.\-]+:/ ||
> +		      $line =~ /^\s*(?:[\w\.\-\+]*\/)++[\w\.\-\+]+:/ ||
>  					# filename then :
>  		      $line =~ /^\s*(?:Fixes:|Link:|$signature_tags)/i ||
>  					# A Fixes: or Link: line or signature tag line
> 

Ping?

Thanks,
-- 
Jerome
