Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE2D3A5E20
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 10:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbhFNINu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 04:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbhFNINr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 04:13:47 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D41AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 01:11:44 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x24so14045264lfr.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 01:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0BEbkxd+coc4mV5frYA2CTc/Kx4z/lGk05PAH5ifxEQ=;
        b=iz0osfI7UH34CCxwg2BuXZJkJ51thqYSdaT1B6BsjC7rKW9nXM5RjMn5wRN3KgeWfF
         GUvBfXgPCU8SPpHYb8XbtGPVdTazBWIrGz7Wuy22QcbjbnekhxQH+cqbttNVYDBjpbF2
         WPfjnDvExbl5cZyouylQoBU7iN6bYOSO1AGQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0BEbkxd+coc4mV5frYA2CTc/Kx4z/lGk05PAH5ifxEQ=;
        b=CDRIQekz/DXv12a5V7emn0ZcCJGqyOSNW8mm5V0SGry8w+hiRWxGkPfNjfB6tXNKhw
         bPvwhBdU9fAbiKs7nM1ymkmeW7iH26tQJalIYCuFokLxrkXvCMbKXPeKvugN8+n5v4mc
         YIk/LTGNE2b5qYDsze7AZgjNFKE45iOzkq2p4411nsGQXrIjShjydPCx3XEPb1Ts9N+W
         rTNw3BD6TBsO5GoL5ceZAxkIgNf8AQ6WjvyZPYXunQdKWXRHiG2VTkIOvxDuy9bxNHKb
         00rHDJhPziJ0JWKL2TB4PfjPqokpcGn6ezLE1fQp3Az7SFS4BEF3wcPpbkb6yoW350ZL
         afRw==
X-Gm-Message-State: AOAM530EhYNhHTJJqiHvW3k93ol0LJa8e8fsGOHKFAOkEgL9/qOgkHlm
        0jTiiWWMKEmqlEEPxkod9jcIcll1fIg8ow==
X-Google-Smtp-Source: ABdhPJzTAEL38B3e9u48hCVTMl3da8TxUJ4f2pUNSzat8WRewW7XqvBpnHXN/mNz0imfhNOx2TTpHQ==
X-Received: by 2002:a05:6512:318d:: with SMTP id i13mr11784701lfe.407.1623658302652;
        Mon, 14 Jun 2021 01:11:42 -0700 (PDT)
Received: from [172.17.20.33] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id c15sm1403909lfh.32.2021.06.14.01.11.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 01:11:42 -0700 (PDT)
Subject: Re: Panic on ppc64le using kernel 5.13.0-rc3
To:     Bruno Goncalves <bgoncalv@redhat.com>
Cc:     linux-kernel@vger.kernel.org, CKI Project <cki-project@redhat.com>
References: <CA+QYu4qxf2CYe2gC6EYnOHXPKS-+cEXL=MnUvqRFaN7W1i6ahQ@mail.gmail.com>
 <d13db73d-0806-00cd-ff84-5f5b03ffbef6@rasmusvillemoes.dk>
 <CA+QYu4oFGkP1G+9TqGtqffgOEBycSMKtFbV-1X+kL4NeTyEegg@mail.gmail.com>
 <45ea5042-9136-6f0c-144c-f09d05cd69ed@rasmusvillemoes.dk>
 <CA+QYu4rF6Bx5OwLzBSam_VXJ6gWqSjTocxTNxanfHuV5nZuzrA@mail.gmail.com>
 <4434f245-db3b-c02a-36c4-0111a0dfb78d@rasmusvillemoes.dk>
 <CA+QYu4q4HBCRo_e9i0WZ2mvm0w2xRC5RkPDQ4h=r9ybOtNXqWg@mail.gmail.com>
 <CA+QYu4pMHaUna48RJtn2cBZD0bHjoQEQcdrUKZbHT0-cm7g4Zw@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <32b37ca7-fde8-8f9a-5631-a88857324803@rasmusvillemoes.dk>
Date:   Mon, 14 Jun 2021 10:11:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CA+QYu4pMHaUna48RJtn2cBZD0bHjoQEQcdrUKZbHT0-cm7g4Zw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2021 10.03, Bruno Goncalves wrote:
> On Mon, Jun 14, 2021 at 7:47 AM Bruno Goncalves <bgoncalv@redhat.com> wrote:
>>
>> On Fri, Jun 11, 2021 at 11:49 PM Rasmus Villemoes
>> <linux@rasmusvillemoes.dk> wrote:
>>>

>>>
>>> And, perhaps asking a silly question, does the crash go away if you
>>> revert e7cb072eb988e46295512617c39d004f9e1c26f8 ?
> 
> Okay, indeed the problem is not with this commit , I've just hit the
> panic with reverted commit.

OK, thanks for trying and confirming. Unless I here otherwise I'll
ignore the ppc64 issue (there's another report, with completely
different symptoms, on that patch which does go away when passing
initramfs_async=0, so something does seem to be weird around it).

Happy hunting.

Rasmus
