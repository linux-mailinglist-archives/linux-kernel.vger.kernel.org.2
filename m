Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05CA63FA6DD
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 19:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhH1RCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 13:02:52 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:57299 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhH1RCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 13:02:51 -0400
Date:   Sat, 28 Aug 2021 17:01:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1630170087;
        bh=m4z6gVadcGbVtyF3I8oWXqiPAQ5Cu/iRMHvkRQTz0Fo=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=m8Hjn4X01ayX0TuUWqvV5pC8ZIRL3TQew3+SG+bucXjNHB8fHyG/uYYaP/Mz/T5sm
         sPiNIajIghLJBOLtHB930cmUHT4NtKOiD65jg1tzXKWEmaOH6n5jJPF2y9GVzXgnNE
         y/3RHjOd6Xpc1ybGnmCp/4F+1hKwnt6gZgQehuXkvXKFaSWH78pjCKsPQVBZwTXRcM
         OWFu0msrdNDxBLR0tFrCfuN0hSiAuBcPP4TTVhtQ2QtlGO+/xZ/YIv1dpRIbPDUIRn
         d3lV7CGzlay3sMvd6Ij4rZpZYKX1E/tg28akJXHptZXfxloEoIkLKoK9Q+zmkNRQ/z
         EQo9ySFy7+zIw==
To:     "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>
From:   Simon Ser <contact@emersion.fr>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH] GPU: drm: fix style errors
Message-ID: <AAXPzlqQa4LEHiBG9xMqCJ0pITmtdyx_lOfTKqWVGLouvv4I9Xt05XUcAeTi0LE6EwvBjeA5yWuQxDLfoXT9eTl1PyJhw-TBT4muamOjv-s=@emersion.fr>
In-Reply-To: <20210828123942.1556-1-asha.16@itfac.mrt.ac.lk>
References: <20210828123942.1556-1-asha.16@itfac.mrt.ac.lk>
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

Reviewed-by: Simon Ser <contact@emersion.fr>

Pushed to drm-misc-next, thanks!
