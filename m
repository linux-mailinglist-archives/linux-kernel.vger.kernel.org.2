Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB834429F8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 09:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhKBJAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 05:00:42 -0400
Received: from mail-4317.proton.ch ([185.70.43.17]:24152 "EHLO
        mail-4317.proton.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhKBJAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 05:00:40 -0400
Date:   Tue, 02 Nov 2021 08:58:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1635843484;
        bh=zRwWsMDd5Kf2yQpedEA3Ka2dLpgNvYvwuOL0uYq4mxY=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=I7BfR8Tm5PFeWXoE8R0R//TQF8/hy3Tt4bIF1B90AgDR1K9YLk1RlV8S8qJmBoUMI
         lp2dg7wtxW+xC6KpndMvEP7ddzQNMk5ZzLdFd/E26s2sKCR5c6H67GImNkJxofQeUk
         1e1odJREXzGHTpVVk9dYj1eJ+0BQ/L71EXZu6jqC3VIPt+4UuaZvmeAnbC1KqY9hbY
         eTJKJGwMcNUtLeFZi6h5eOF6AndMA0/FzV4yGlL8kz0juAbpAk/nIvnzbxbeoPxO9l
         YDU62Msd2bdbNKdlmh9J9vR5DxkfE5H7AfqIs/b+nbP46otSt8NeQdL/ulVpK932V7
         hgW4O+Qd6QbtQ==
To:     cgel.zte@gmail.com
From:   Simon Ser <contact@emersion.fr>
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, nicholas.kazlauskas@amd.com,
        qingqing.zhuo@amd.com, aurabindo.pillai@amd.com, Wayne.Lin@amd.com,
        shenshih@amd.com, nikola.cornij@amd.com, Roman.Li@amd.com,
        Anson.Jacob@amd.com, Aric.Cyr@amd.com,
        meenakshikumar.somasundaram@amd.com,
        jiapeng.chong@linux.alibaba.com, george.shen@amd.com,
        syed.hassan@amd.com, lee.jones@linaro.org, ye.guojin@zte.com.cn,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH] drm/amd/display: remove unnecessary conditional operators
Message-ID: <lvX4AA55dPGJGyFf1ncXCnqomRKljUmW8TXAJV88VrSpYt2gSTrcK3JnCbGl5zsRJ4Gqs7-MAXIuCGr01axsnxkzDO5STy3cMMAo5SL7wOE=@emersion.fr>
In-Reply-To: <20211102070125.4445-1-ye.guojin@zte.com.cn>
References: <20211102070125.4445-1-ye.guojin@zte.com.cn>
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
