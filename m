Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7673ACC47
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 15:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbhFRNfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 09:35:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33353 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233003AbhFRNfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 09:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624023213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hYXdgxT03Bgph7WTDdx6mZuCz5B0Ty3MU8GPyXf11Ac=;
        b=SOn9o6vc45xs1Ur1AzNTGiMQGL2gvk7ONbrFnVXnrKMUrftn043UKqRedzW3zZ4kfji/jM
        m+0SGCr9UhX9tXFLfRrNMwxK0oexLenPdxGKzlsXeL2x9w7lB076HRHnBAvTuegZWtMK9N
        kGSdnvaaK2cvbK4Pz5/6iLxmlw4k3qs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-9IwffEJNN1qmfXQ5Gn-L3w-1; Fri, 18 Jun 2021 09:33:31 -0400
X-MC-Unique: 9IwffEJNN1qmfXQ5Gn-L3w-1
Received: by mail-ej1-f71.google.com with SMTP id p20-20020a1709064994b02903cd421d7803so3961661eju.22
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 06:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hYXdgxT03Bgph7WTDdx6mZuCz5B0Ty3MU8GPyXf11Ac=;
        b=SUM3YRjWl/7Jyj9J4ed8fswANKtWD4onLHvKHZLmcrMdGJSsoYIyTtjHYZBitYxaiP
         SxTMaIOjdMu1DbwmiOru6Mqbr3kdhml6I4PaHCmMWNy4jSZF1UZ2+Nn6wgy+fr4cdepL
         uT0bL5sS19z49vTiGfdu1Cd3M6HpFd1uP/XrBEdLEbZ/5n/aUV0WWtQi/DG4pPBFsLSw
         ECqbd7HLVB9M05ZSRC87RNQye9kp8W60sFn6vpaq31RiVUySKZi9IC8vqh7aSlECDf4j
         3Mrq8Dld+Oxqke0yr9qsLJbvWQ4FuY66xThLMpDZCaoJWIgBfoOwuNgDBbTlh/Ft9wnc
         V7tQ==
X-Gm-Message-State: AOAM5301k+MTRHEQeqyFOyjOZ8tIirVD3x6lyhrKMv2rNH2UQN0Z71pD
        ekMDM9zxjpHMqifmEyFUSBhg554Kk6GDvQ3eG6jMHqAfPZisQz/+i0+rS5pqnqgW2aIowh+zf6K
        0wa6JEWnCp1I3mOeymM6L+ySu
X-Received: by 2002:a17:906:1c84:: with SMTP id g4mr10664767ejh.99.1624023210731;
        Fri, 18 Jun 2021 06:33:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUYge8g478XkDG3g7ixMeylORBPehaGxAmNlFEtobCLRtX380pG18G0WHDaGLeP37/8MZjAA==
X-Received: by 2002:a17:906:1c84:: with SMTP id g4mr10664754ejh.99.1624023210629;
        Fri, 18 Jun 2021 06:33:30 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id y20sm6074920edq.69.2021.06.18.06.33.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 06:33:30 -0700 (PDT)
Subject: Re: linux-next: Signed-off-by missing for commits in the drivers-x86
 tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Gross <mark.gross@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20210618083731.2481f7b5@canb.auug.org.au>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <cce5200d-d408-cc5d-3ea2-4e299488cdcf@redhat.com>
Date:   Fri, 18 Jun 2021 15:33:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210618083731.2481f7b5@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/18/21 12:37 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Commits
> 
>   de5db8ebe7de ("tools/power/x86/intel-speed-select: v1.10 release")
>   f45d05b29cca ("tools/power/x86/intel-speed-select: Fix uncore memory frequency display")
> 
> are missing a Signed-off-by from their committer.

My bad, sorry. I've just done a forced push to platform-drivers-x86/for-next to fix this.

Regards,

Hans

