Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A8E3E99D2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 22:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbhHKUl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 16:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbhHKUl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 16:41:28 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7870C0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 13:41:04 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 14so3914794qkc.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 13:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=inYZ30BOLCFmgjt9HfeCp/TY/OhCcf+R7LqwPWc97xU=;
        b=vFVVPt9ttpnqzk26gCVpoJaqXoIbN1/GF7OPtdMUn9hb2kY7DXjDSgo1ifrcl+btbl
         ALUtKUuuUV4exmtwQBFRe6kUIw8GB0y0/zLtuEnNtkRtHVLkvRYClOoY/gENS0gjdlQh
         c4yN3oPsS5u32KL0uyxNmh3NEtSnl1QcZku50vGvQWFcKCBLMSOmOjpno+JyaxLEkJeB
         gFipjt9MecWLcKNelqV+vTcygwZC1y1qNKZlolebEUumtTSwFfL9ZhdbjOiFa4ZRB3+x
         /s5/QoByh/oWx4yObb40fx8Ux5g2JgzHcl/NKkWlN9BkszMhEGALah8HxQa7BkMHnuqY
         eIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=inYZ30BOLCFmgjt9HfeCp/TY/OhCcf+R7LqwPWc97xU=;
        b=ATgdmapWvalcS9OxcAJG3drEPokzM7upvI5EWKqkfOxfmAdHPOYfdNzevpJsX7HQAj
         hQT4WkrVgNLwF1ffL8i7qoa48XaAP/3MhyzxDB5odm7w3/xfdWkVaDalFlevAbjajLiX
         AoOlUNQhvvMa1llA4a+lZdx9HqY/G54K4Ad2qGlrsMtR07xSNjm98ei983NoiNGCuUWl
         bk8K88f2TSOqXcsH6k9gwsCYLbjgK03iuLSZ1kEmLPc9++Au9qEDDLXVRfO2JIXk2MFi
         1LkVEzql9fZtZ/IpOecBGjlOqVWwBhnNiehSDzR9rc3EBBO0+a+HqJPQF8BH2pDoJLeY
         nRaA==
X-Gm-Message-State: AOAM532nIU+wd8Napb9k24pXHCTOJ+hK2OFUqFSGItTq+HfeK/NwHbhv
        xRXRl5sEPZAiIB0W2JlSw+LoQcvEI3EuBg==
X-Google-Smtp-Source: ABdhPJwFs6S4osGKAbtUaijXVplaXTYDu0BDkltgjYSF76b2RKCRx/0FNconbCe8HoreOCNlkRtzhA==
X-Received: by 2002:a37:d43:: with SMTP id 64mr959993qkn.430.1628714463671;
        Wed, 11 Aug 2021 13:41:03 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u189sm168648qkh.14.2021.08.11.13.41.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 13:41:03 -0700 (PDT)
Subject: Re: [PATCH] btrfs: Allow read-only mount with corrupted extent tree
To:     =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>,
        linux-btrfs@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-kernel@vger.kernel.org
References: <20210811200717.48344-1-davispuh@gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <ccd23bbb-1404-0727-383f-2412a5d4df36@toxicpanda.com>
Date:   Wed, 11 Aug 2021 16:41:02 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210811200717.48344-1-davispuh@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/21 4:07 PM, Dāvis Mosāns wrote:
> Currently if there's any corruption at all in extent tree
> (eg. even single bit) then mounting will fail with:
> "failed to read block groups: -5" (-EIO)
> It happens because we immediately abort on first error when
> searching in extent tree for block groups.
> 
> Now with this patch if `ignorebadroots` option is specified
> then we handle such case and continue by removing already
> created block groups and creating dummy block groups.
> 

Already done and queue'ed up for the next release

btrfs: rescue: allow ibadroots to skip bad extent tree when reading block group 
items

thanks,

Josef
