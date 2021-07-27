Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513C63D7E6F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 21:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhG0TV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 15:21:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21671 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229737AbhG0TV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 15:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627413687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uGKrqOctliwjS0X4Sldrr5gAehx34qSkobccEFs4N28=;
        b=M55LneEPe/LI9dExTQmCWsW8+/EY1BJpSkfcfCnsUenV25TAN3BpyRmfhTuLORhyxBR9qR
        26cQws3WyFBcq5QnI787dIK1g142dp7PLRT6yLKK5cSzMiJuxQw2H2zpvt2gyUNpeWfg5T
        F/a3jfCmDlFXmwlIhPy0to22nHUvXro=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-nIEeAEjwOISFaYmjaVl-hQ-1; Tue, 27 Jul 2021 15:21:26 -0400
X-MC-Unique: nIEeAEjwOISFaYmjaVl-hQ-1
Received: by mail-qt1-f199.google.com with SMTP id w19-20020ac87e930000b029025a2609eb04so6847662qtj.17
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 12:21:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=uGKrqOctliwjS0X4Sldrr5gAehx34qSkobccEFs4N28=;
        b=To7Y+scO6D+CWEPkN6QVzBL/eaLBAb2MbMBmJFFGxDUtniA5E8+ZMMXlOIp3G+9S1q
         HQ27fqfyuAruDBxNWmABqgL1iCcLU7hZfsnkTarLxgwIVNqZsH+V28jFrEyjPnHIPhga
         h98ekSw1cXgx8/UXDhFJyKwW9i+uOqqCcBnXBf7nqMmGXxEQ9Jmz0O0a2Csel4XS5W22
         n/ObPJ6eibq942IM8U0NEOY5CixvC/YovLvZa3Q+V+5X8+a44MzME6G+zIKlzBL6VdFc
         la0Wtq8XApH+ppSPX5UImj8F+I3Ip5i95cBxUG2cNhp1PF5PzKUMbLZP14ho/KMYTV8a
         yRlQ==
X-Gm-Message-State: AOAM532cLRrIECrWzFKNwaBRQm/Lo+gGRAS5GYLhXYVIZ2x7eRPk56On
        Wocby9sW/P4cdkLadJXzcuFAGKoV7FmHAHcXcG3+l0T757lQmdpJOmggbtmU1J5o4MN56Py56SS
        baqD3W3ThwtGhcYRgX5Kkhpl+
X-Received: by 2002:a05:620a:13a1:: with SMTP id m1mr22845954qki.91.1627413686247;
        Tue, 27 Jul 2021 12:21:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmGZgQ7NnlCRlYkJ8czqKlAtNQKQ4f+q3WwLktTQbZsVbgcLLxWZj0DA7sLlD/FFLHp/3Lpw==
X-Received: by 2002:a05:620a:13a1:: with SMTP id m1mr22845940qki.91.1627413686080;
        Tue, 27 Jul 2021 12:21:26 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id r16sm2124371qke.73.2021.07.27.12.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 12:21:25 -0700 (PDT)
Message-ID: <79c5a60fc189261b7a9ef611acd126a41f921593.camel@redhat.com>
Subject: Re: [PATCH v3] drm/dp_mst: Fix return code on sideband message
 failure
From:   Lyude Paul <lyude@redhat.com>
To:     khsieh@codeaurora.org
Cc:     Jani Nikula <jani.nikula@linux.intel.com>, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, rsubbia@codeaurora.org,
        rnayak@codeaurora.org, freedreno@lists.freedesktop.org,
        airlied@linux.ie, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 27 Jul 2021 15:21:23 -0400
In-Reply-To: <d9ec812b4be57e32246735ca2f5e9560@codeaurora.org>
References: <1625585434-9562-1-git-send-email-khsieh@codeaurora.org>
         <87zguy7c5a.fsf@intel.com>
         <a514c19f712a6feeddf854dc17cb8eb5@codeaurora.org>
         <2da3949fa3504592da42c9d01dc060691c6a8b8b.camel@redhat.com>
         <d9ec812b4be57e32246735ca2f5e9560@codeaurora.org>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-07-22 at 15:28 -0700, khsieh@codeaurora.org wrote:
> 
> It looks like this patch is good to go (mainlined).
> Anything needed from me to do?
> Thanks,

Do you have access for pushing this patch? If not let me know and I can go
ahead and push it to drm-misc-next for you.

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

