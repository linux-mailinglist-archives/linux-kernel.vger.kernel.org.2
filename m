Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D233DBDD5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 19:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhG3Rhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 13:37:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42507 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229773AbhG3Rhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 13:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627666665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vCAX2Kmv6swjeLPb8XTOG5P1FiP7p6CkcukVbAna/IY=;
        b=Wj1SB0Wn+nRjCvC4H9QH3Ba4r+yWpshgWEQGr8pFwpKsgfEATzTGM5ZWhJeYhzu8rAanEQ
        InEJLJSKLgPiIwLqlfyQRRAWB0SWXYS7MYBdHs+wnrX+RV2pDh6I4godMvKDVG06Gt2Ms/
        J/IPnG5Q+VgujKqLbQLEGktKw2fa4dE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-GGInJzGOOZa70RkxYpnhPg-1; Fri, 30 Jul 2021 13:37:44 -0400
X-MC-Unique: GGInJzGOOZa70RkxYpnhPg-1
Received: by mail-qk1-f199.google.com with SMTP id u22-20020ae9c0160000b02903b488f9d348so6141768qkk.20
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 10:37:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=vCAX2Kmv6swjeLPb8XTOG5P1FiP7p6CkcukVbAna/IY=;
        b=hqOPYwg7KzKFlKmqkUCvrevBFVEodLGaqHAegjOHh9SNyTAJAWz/YVn0MpjerUCSCh
         REvQn/rbl9GOw/2Jn5lI47QuBcntVY83h2yi5stA3nfQFDNJnugNMxYdCIdCz/AnxIHI
         JSl40vCra/m6VcOmfQv4LgzmGi+EW961DHDFxAaRYeuCmPcezEwqj8mBvGEWhUIedhSX
         A6e5uStHSsx57VcsBDlhi3iEYxYGXLyjqQNr+XhDPDRCYCrWVxBdw73uroGv1+eBWVEu
         tnqtk7BZjW4vf3eCJamHyGlJ7nJYxId0wuNagDJqWSL6DWRpJx2aDSfDpv5XEdvk+hI5
         kVOA==
X-Gm-Message-State: AOAM531aseJOx3huUieIDiaIwK/rxqPtJJzMn0eXz5oMWG9a2eaTeIwd
        p5Unpij7vu5El/hZS2U6uIBk/JoWwMcOmw7HWodPfDHJ7Y1lACUgoEtNkIFOwOleCQvZ/8dLyi3
        ypp0C19FHvTPcjMNd6AX5YGdh
X-Received: by 2002:ac8:548a:: with SMTP id h10mr3208420qtq.89.1627666663761;
        Fri, 30 Jul 2021 10:37:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaE99KUbpDYu6wEAU0dWSDkIcZGkRC7mBhIpMTdzhBiTASsmfcotVAkvrC5BAu6v76Y1uh6Q==
X-Received: by 2002:ac8:548a:: with SMTP id h10mr3208401qtq.89.1627666663488;
        Fri, 30 Jul 2021 10:37:43 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id a20sm896826qtp.19.2021.07.30.10.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 10:37:43 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 0/2] locking/lockdep, drm: apply new lockdep assert in
 drm_auth.c
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        boqun.feng@gmail.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20210730041515.1430237-1-desmondcheongzx@gmail.com>
Message-ID: <ac36ec31-df97-b2ce-39f1-182e6859a1a0@redhat.com>
Date:   Fri, 30 Jul 2021 13:37:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210730041515.1430237-1-desmondcheongzx@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/21 12:15 AM, Desmond Cheong Zhi Xi wrote:
> Hi,
>
> Following a discussion on the patch ("drm: use the lookup lock in
> drm_is_current_master") [1], Peter Zijlstra proposed new lockdep_assert
> helpers to make it convenient to compose lockdep checks together.
>
> This series includes the patch that introduces the new lockdep helpers,
> then utilizes these helpers in drm_is_current_master_locked in the
> following patch.
>
> Link: https://lore.kernel.org/lkml/20210722092929.244629-2-desmondcheongzx@gmail.com/ [1]
>
> Best wishes,
> Desmond
>
> Desmond Cheong Zhi Xi (1):
>    drm: add lockdep assert to drm_is_current_master_locked
>
> Peter Zijlstra (1):
>    locking/lockdep: Provide lockdep_assert{,_once}() helpers
>
>   drivers/gpu/drm/drm_auth.c |  6 +++---
>   include/linux/lockdep.h    | 41 +++++++++++++++++++-------------------
>   2 files changed, 24 insertions(+), 23 deletions(-)
>
This patch series looks good to me.

Acked-by: Waiman Long <longman@redhat.com>

Thanks!

