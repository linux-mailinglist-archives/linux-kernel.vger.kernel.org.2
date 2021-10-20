Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E60434F84
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 17:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbhJTQAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 12:00:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37974 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230494AbhJTQAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 12:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634745476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jLto73EhLPS0L9ZkqSvlOYI3NN47XcPBB+0LgWwxrPs=;
        b=KPQTiVdcpllPIFrsXNiJBj8IoggCclNKts1eTH1CrUbJX5EOmJRqULIAt3w5A2ttqb893O
        np2YPRZqijQE4Pmo6k8ZPRu97ftxFl4Icuum/N1ZV+MT4GdigPDbNFOBSiJInIs973VS1J
        MmlKaIsuGOT+cYT3xowxkFpCFbbENxo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-oY8AaOaxMzmZ7bNsiufqxQ-1; Wed, 20 Oct 2021 11:57:54 -0400
X-MC-Unique: oY8AaOaxMzmZ7bNsiufqxQ-1
Received: by mail-qt1-f199.google.com with SMTP id w12-20020ac80ecc000000b002a7a4cd22faso2445870qti.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 08:57:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jLto73EhLPS0L9ZkqSvlOYI3NN47XcPBB+0LgWwxrPs=;
        b=SJJ2iXTI3t3mcY318FrfEBNU6+SneOrkzpG254MPhXdH23JzTvBTOEJSgv81ZpLbSl
         IS07JG8WATTU+u5xR4BqR7sSWDehbYlbKugg1bxP6k2Icdu2EYWpdRlRQlCB6581F7E7
         YBzSBpJdcZTyJxDvfGTHQJ++QhMUdVL3gIHGRLzfUupDmzM+Atmb/O3dJEb55bnAZZxN
         ydlYWxM1VZP+K8RjSHA2TX1VSVKGzQmCwxULrrQKWPRyrNA+4khOv8CPLmrkaJHpHgh1
         89drDAgyXOaaFsJTgnMmGvFqmvHkhmg7zmbAO01RT0HmfIpNdJ+RycL124BGyboAL0wT
         bzcQ==
X-Gm-Message-State: AOAM530J16IW48tkdLnRUN97hjxZTZkuvr/tBNL5RffXQBakMG5y2+Ed
        w3SdexqNbo8HaYaYrQ2oqd1sYm3CZkLD22xf/KpvQRti9sXjmul2eQzirI9IHaIIOQY2CwgM5JX
        dWUtmPyTQB0TIk3IW6H1EXFZj
X-Received: by 2002:a05:620a:1a05:: with SMTP id bk5mr316334qkb.195.1634745474180;
        Wed, 20 Oct 2021 08:57:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZoTnZ0OHMmoxPxPmPFa3CNoA6uJD4lYCWnohOPWpdwlmRnW7hfck+i2GP/Eb2U69wer4+Dw==
X-Received: by 2002:a05:620a:1a05:: with SMTP id bk5mr316311qkb.195.1634745473907;
        Wed, 20 Oct 2021 08:57:53 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id bi26sm919806qkb.102.2021.10.20.08.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 08:57:53 -0700 (PDT)
Date:   Wed, 20 Oct 2021 08:57:50 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com
Subject: Re: [PATCH v2 08/14] x86/retpoline: Create a retpoline thunk array
Message-ID: <20211020155750.3u74bkcp66leeyed@treble>
References: <20211020104442.021802560@infradead.org>
 <20211020105842.981215247@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211020105842.981215247@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 12:44:50PM +0200, Peter Zijlstra wrote:
> Stick all the retpolines in a single symbol and have the individual
> thunks as inner labels, this should guarantee thunk order and layout.

How so?

Just wondering what the purpose of the array is.  It doesn't seem to be
referenced anywhere.

-- 
Josh

