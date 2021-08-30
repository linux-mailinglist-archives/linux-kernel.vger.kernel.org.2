Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852493FBAA4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 19:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237991AbhH3RJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 13:09:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54439 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235853AbhH3RJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 13:09:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630343331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RJ2p1fjjD8ERbYVIX3Rp+Pa17H7hfIARQi230Atxhhs=;
        b=YpVDWu6ltV5LI0GujGU2xhNAIUYbAdEBzndR+gwsxkwCSHhrwgoWTRQ5utoUlL1GZ4co+Y
        8FaBmKIKhn8+c/GsiYICS5b5/GJZ5eCZhIxcritZkdQHAzTAXhBFlqKcOzcNFNu9YIb9HX
        QofoAUpClvQFVNAvh8TOXbIMEmLvMeg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-LnkkWpzTNiGVkequnhfySw-1; Mon, 30 Aug 2021 13:08:49 -0400
X-MC-Unique: LnkkWpzTNiGVkequnhfySw-1
Received: by mail-qv1-f69.google.com with SMTP id b8-20020a0562141148b02902f1474ce8b7so767400qvt.20
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 10:08:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=RJ2p1fjjD8ERbYVIX3Rp+Pa17H7hfIARQi230Atxhhs=;
        b=YWSLzM9CJEC0NOCU5aCbOLrBDsaDfFfNlpot5iTVowbAKgl9e4AsxRQXNQREu+8TPh
         95nxhoRbx/95CtdnnbRxtPJa17epPyUlgDDOzG98f/mQaHBbNdSpDo/PmV7Zhp9dIvpx
         730HEEPyHniIMMvop2z9sm+Rf/SUliK4DwIsOrb1xGnCLt+adLHF6uY1ekuDs4OQZZzW
         wcPrAI4xcuVZKgga2b1HGV91aT2EiWIWoinZY7ugQKJvvh4dCziddT31YssSoE/smDFY
         UibNDAxj02Ax4F/C1Erjq44M8nD5pzAlZ2FiTU/L8Y5VC7mKw3FOXvK0pznyAGEETzS0
         26Dg==
X-Gm-Message-State: AOAM5335vOQpqJeCaCuxbm06EApWtDKFQQ6OYlvtGgCZrkIdt6MFaWco
        nOw9lf/VgcRGkJydWn1CHvTmR8soMka0Z4EFTKD8c6lj1Y2plmaCv865IClsGDQKcno+T802wrE
        LFMGx942z+Bu3BPt/k5+f3Sg6
X-Received: by 2002:a05:620a:81d:: with SMTP id s29mr23761963qks.301.1630343329098;
        Mon, 30 Aug 2021 10:08:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/+cPlJFfzxjZYDasfknZytxGolZm+T7/j6hx198c4EYh9UytMtKYed3Gms4R3lAi7g+R6nQ==
X-Received: by 2002:a05:620a:81d:: with SMTP id s29mr23761951qks.301.1630343328961;
        Mon, 30 Aug 2021 10:08:48 -0700 (PDT)
Received: from [192.168.8.104] (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id g7sm8835996qtj.28.2021.08.30.10.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 10:08:48 -0700 (PDT)
Message-ID: <c0e64fb9332b03c920de05be4c4c27f916ff6534.camel@redhat.com>
Subject: Re: [PATCH AUTOSEL 5.13 20/26] drm/nouveau: recognise GA107
From:   Lyude Paul <lyude@redhat.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ben Skeggs <bskeggs@redhat.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Date:   Mon, 30 Aug 2021 13:08:47 -0400
In-Reply-To: <YSzMR4FnrnT5gjbe@sashalap>
References: <20210824005356.630888-1-sashal@kernel.org>
         <20210824005356.630888-20-sashal@kernel.org>
         <6607dde4207eb7ad1666b131c86f60a57a2a193c.camel@redhat.com>
         <YSzMR4FnrnT5gjbe@sashalap>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ahhh-ok, that makes these patchs make a bit more sense then. If Ben doesn't
have any objections I'd say these are fine to backport then

On Mon, 2021-08-30 at 08:17 -0400, Sasha Levin wrote:
> On Tue, Aug 24, 2021 at 01:08:28PM -0400, Lyude Paul wrote:
> > This is more hardware enablement, I'm not sure this should be going into
> > stable either. Ben?
> 
> We take this sort of hardware enablement patches (where the platform
> code is already there, and we just add quirks/ids/etc.
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

