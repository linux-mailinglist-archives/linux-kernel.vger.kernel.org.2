Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33A33BE511
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 11:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbhGGJGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 05:06:20 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:36949 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbhGGJGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 05:06:18 -0400
Date:   Wed, 07 Jul 2021 09:03:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail3; t=1625648585;
        bh=FfzoFy/JPOfylMDSWf+V05WzCz+VvbqhnbLqlhgFSx8=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=ljxtuZM65q38o0IdXEGPYwe0aG0xa7D7WyJPn6tKjLJFJcC7flV2mmW5khXcCFex1
         vJSgPp2kAjkSWyHproJkq38PP4V41BvS2OJOomjwzB4nOW7/MLiATIOeTE2TMftSaE
         bJRLsG3u2x7GXLdYRKNztRATQbXOBvSiWZOtwbewcfevcpT1cqFeaKzy8LVKif4YCp
         moZ3dYYdMly+OCsY7mTIMk/+in8WBZi3sHl+fPl7cvXvsv2aCItmE36TaUhLI3jfV6
         ug5cPO1ShVIjtXioziDpaXn77Z+tBfIdHCHxaodC7rIqA9b9YI0OzIomC73J/kln/a
         rsg0ooJaaismQ==
To:     Raphael GALLAIS-POU - foss <raphael.gallais-pou@foss.st.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Yannick FERTRE - foss <yannick.fertre@foss.st.com>,
        Philippe CORNU - foss <philippe.cornu@foss.st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE - foss <alexandre.torgue@foss.st.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Yannick FERTRE <yannick.fertre@st.com>,
        Raphael GALLAIS-POU <raphael.gallais-pou@st.com>,
        Philippe CORNU <philippe.cornu@st.com>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH 0/2] Add "BACKGROUND_COLOR" drm property
Message-ID: <31K3xupK1-7HNWorHqIwGwgEJl-1XdFjUQEoNYm6yB-lRoZ8kq5quRji_r3mzPZ0bUayLef6xPfQDiETgZp9lR7vUpDn2nB_37ncSd-J0Wc=@emersion.fr>
In-Reply-To: <20210707084557.22443-1-raphael.gallais-pou@foss.st.com>
References: <20210707084557.22443-1-raphael.gallais-pou@foss.st.com>
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

Hi,

Thanks for working on this. Do you have plans for user-space
implementations and IGT?

Thanks,

Simon
