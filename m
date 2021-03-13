Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 861D5339FAF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 18:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbhCMR55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 12:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233951AbhCMR5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 12:57:30 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EB1C061574;
        Sat, 13 Mar 2021 09:57:30 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so12294935pjh.1;
        Sat, 13 Mar 2021 09:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XWqqEAms8sNytX1q8x1aC4Bsb7JTXB3O8MKgVFf4nEs=;
        b=NbdDF5rk+2ySutxq2F8YTAZW1LhO1mByBrLtBnJgoUHrBjFNi8p9yGz9u0PX0WRmEo
         nOpad7B/cUBvR9FgtROSnO1Bo4/GFh5OndcoRPelMA3UEAsOa32nV2YlC6kApWweb4pX
         +TYc1u6xoslM5UIBqS+mj3JGrJ1gKpHX/1mbYdxGOd6S5van36EXnCyHaiog7UBVe9Rq
         P1zeWJiy7sqYU1HwSZSKpynZs28hwhv3OoPoXBDwpzCzo7r+lZ2Zp5KT0OejB1vNjh2f
         g3bwiNSGu+xE8WeHNfjFqHpZndKkfGhiS0mPdR3G4zkSVhIRFbwAbMBOxu7ijeSbzB2v
         REZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XWqqEAms8sNytX1q8x1aC4Bsb7JTXB3O8MKgVFf4nEs=;
        b=NCO7TcBJoZf6COag9CSSpjGXz8zCpP+44Q+o9aGzSJxUKCQlRAvedGWvi8usCIZONW
         s9H68HhlbU3hlPuK5l4FBP3u3uMFDrnxURj+yThXrd6Cju+Jb9hUhPIJXPbRhnBP1/B1
         iKuQxkaSzdCIZu8NelKQPZFbLOVnuyZ5fuT+8jRKKMqGlySTX/MfTzX9E+7rZXxDTJXo
         HQj1/TckCb0kKAchOge9HwTD8JPGW833ORpblLl3Jc07vva0osy4dLUcsGd4tFNhyyuV
         glvpIPlzsdYXZ9kcQhyJp+Ccsk6WmvRc1SRpZmqSQ4ncmZpJGoJeXViCXk+4bJwvrV5j
         LXpQ==
X-Gm-Message-State: AOAM5312cj/VoFuwCKxR5dnAYwTjEklLrgiAs5iG2lp0ZLKzeuRFzwju
        YBt+4XQc/99nHrARIiZ4cq0=
X-Google-Smtp-Source: ABdhPJyW4hxMUc2ue1vPItBeQmjHHU/DkJuIytsHKQp3BVKJGi4C8ZM8tINdpxH1vJ1ysdRFZafa5A==
X-Received: by 2002:a17:90b:305:: with SMTP id ay5mr4647830pjb.74.1615658249921;
        Sat, 13 Mar 2021 09:57:29 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id m17sm8787619pff.88.2021.03.13.09.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 09:57:29 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        =?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <rafal@milecki.pl>
Subject: Re: [PATCH Broadcom/stblinux 2/2] soc: bcm: bcm-pmb: add BCM63138 SATA support
Date:   Sat, 13 Mar 2021 09:57:28 -0800
Message-Id: <20210313175728.3844391-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210114175339.19920-2-zajec5@gmail.com>
References: <20210114175339.19920-1-zajec5@gmail.com> <20210114175339.19920-2-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jan 2021 18:53:39 +0100, Rafał Miłecki <zajec5@gmail.com> wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> BCM63138 has SATA controller that needs to be powered up using PMB.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---

Applied to drivers/next, thanks!
--
Florian
