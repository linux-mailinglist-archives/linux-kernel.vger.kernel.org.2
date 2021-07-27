Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622843D835B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 00:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbhG0Wok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 18:44:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43067 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232336AbhG0Woj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 18:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627425878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DK7QOr93tpO6ZeVlMj41CdryUvlpzzBljDxRIdRpu00=;
        b=aS7zUsuM5UQtb+Us2EOaBcMcSK9K/GgyFP6zqoTYnqc8D3wlO8IMvwQHzSTa/eQohm4m3v
        NyD0LEJDmo23madzlTo5Ru6HmaehbmFea/MSzrVHkQ2FizYsbeFugNfHeCiUi5xgws3Tyd
        YcdiKHvIUiSJ1vQKy7zZ/RcpqB1z9rk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-TYNdhVp0Pr6O5C7rxxyI_Q-1; Tue, 27 Jul 2021 18:44:36 -0400
X-MC-Unique: TYNdhVp0Pr6O5C7rxxyI_Q-1
Received: by mail-qt1-f198.google.com with SMTP id v7-20020ac874870000b029024e8ccfcd07so7344789qtq.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 15:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=DK7QOr93tpO6ZeVlMj41CdryUvlpzzBljDxRIdRpu00=;
        b=PgvgdFpkW/hp+2zcZUI4Vytn0hFJSx5/kO+BEhm7cpKh3/4tVYiZyJ7pvPpcSpr7Bq
         5CE3H5Wvu10X2U/9Q+BJ3cSv6YeYcaXcWKdYOtKIMlM3XLa6cic6M9qg3iQdMltKoL0+
         VljHgdX5sOPZAxEgSl0NkZz69MHGBMnBeWUKUn76nzu/71Ako79dJDrP548FUZR2dm1B
         xP9FaiUnHoCzEgjAF+/KWwXYQ4wZ3xvzhsVWHTEyghYdd3tAqpvsK5Z0vH5xNj/9v81z
         btbmSA4n+SLTiIndu+gKSe/Fw4tNX71AFwaUQlpM52KWBftt0wHt/mS7sz1fXfGL7ZZk
         2a+w==
X-Gm-Message-State: AOAM532SZ73XqPvtzEwKNfjjOKwtmbix09R25Z5JGqCBfEPC9fhuYyaZ
        Y4iJTkPjwPKwqGjiL4dtQRNH0AT603nXl5Sk9r/KMIhbp0npPIsWh5NOfKNxwv5eQr9yOOfySO7
        2guNPayzmxmTFEIWZ+0PPdd65
X-Received: by 2002:a37:a58f:: with SMTP id o137mr24235536qke.451.1627425876354;
        Tue, 27 Jul 2021 15:44:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGj2G2MLvOCQdZF7LANv0fXdRF2QJsKwLJaBjD7XP2EqW1YquS1Ayo6QYNoe1V968s25GfaQ==
X-Received: by 2002:a37:a58f:: with SMTP id o137mr24235523qke.451.1627425876205;
        Tue, 27 Jul 2021 15:44:36 -0700 (PDT)
Received: from Ruby.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id s3sm2051101qtn.4.2021.07.27.15.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 15:44:35 -0700 (PDT)
Message-ID: <e725235a77935184cd20dab5af55da95b28d9e88.camel@redhat.com>
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
Date:   Tue, 27 Jul 2021 18:44:34 -0400
In-Reply-To: <696a009e2ab34747abd12bda03c103c7@codeaurora.org>
References: <1625585434-9562-1-git-send-email-khsieh@codeaurora.org>
         <87zguy7c5a.fsf@intel.com>
         <a514c19f712a6feeddf854dc17cb8eb5@codeaurora.org>
         <2da3949fa3504592da42c9d01dc060691c6a8b8b.camel@redhat.com>
         <d9ec812b4be57e32246735ca2f5e9560@codeaurora.org>
         <79c5a60fc189261b7a9ef611acd126a41f921593.camel@redhat.com>
         <696a009e2ab34747abd12bda03c103c7@codeaurora.org>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nice timing, you literally got me as I was 2 minutes away from leaving work
for the day :P. I will go ahead and push it now.

BTW - in the future I recommend using dim to add Fixes: tags as it'll add Cc:
to stable as appropriate (this patch in particular should be Cc:
stable@vger.kernel.org # v5.3+). will add these tags when I push it

On Tue, 2021-07-27 at 15:41 -0700, khsieh@codeaurora.org wrote:
> On 2021-07-27 12:21, Lyude Paul wrote:
> > On Thu, 2021-07-22 at 15:28 -0700, khsieh@codeaurora.org wrote:
> > > 
> > > It looks like this patch is good to go (mainlined).
> > > Anything needed from me to do?
> > > Thanks,
> > 
> > Do you have access for pushing this patch? If not let me know and I can 
> > go
> > ahead and push it to drm-misc-next for you.
> no, I do not have access to drm-misc-next.
> Please push it for me.
> Thanks a lots.
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

