Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95B23FAE06
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 21:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbhH2Tdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 15:33:42 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:51911 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbhH2Tdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 15:33:41 -0400
Date:   Sun, 29 Aug 2021 19:32:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1630265565;
        bh=dJZln88lN2ZOtbXwmt+yMlSaTT1Nk8VC901yTzLI2ig=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=jcERtoke82bMjrT4YI6VMnly6t2An9WrvCSsN0WX4Bqj2JuG7RXgsiRIQvC4fDq1l
         472BKhcVPkfOxXnbECZ7VrCqW+h3lxg02Uu8uNqaZKpei51bKmryT7B8EHLy3RmtUl
         es80LK8h/fewoTG3iOr+rCxe1QKRmbJG7yu/zH1naRZ963S8tdSnGcam6Rk+KUOm9l
         AwGPV6p8Oxw0oFSkI11GrugSCWJFrNFZdQYMWLpITVyLpI0Oa0k3TNHLJtSkZx9wEv
         AG5/k6MsLoxbGMOV0vnXEVQwjpbCiO9v/xZLsDu3/89kZ+PDAxaSjT34JxI6LHVcYi
         j/PQj2FK3Szog==
To:     Alyssa Rosenzweig <alyssa@rosenzweig.io>
From:   Simon Ser <contact@emersion.fr>
Cc:     dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH] drm/plane: Fix comment typo
Message-ID: <Et1WVGdWQKatnvgF0dk0__fJTr113F_1q4nPYkKG9BMEbOywRbg9NilposzUZNbnQX0PPVi31RpFzoOZ8cRD9gGH5KRC5haFB3pr8iLFUFI=@emersion.fr>
In-Reply-To: <20210829160401.4588-1-alyssa@rosenzweig.io>
References: <20210829160401.4588-1-alyssa@rosenzweig.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pushed to drm-misc-next, thanks!
