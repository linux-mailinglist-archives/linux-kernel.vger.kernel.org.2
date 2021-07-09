Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49DDB3C217E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 11:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbhGIJZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 05:25:59 -0400
Received: from mail-40136.protonmail.ch ([185.70.40.136]:60997 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbhGIJZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 05:25:57 -0400
Date:   Fri, 09 Jul 2021 09:23:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail3; t=1625822591;
        bh=LO9Rp69AEGGH8iMW8uMeJxTykgakbc4R3iWP675PBLo=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=DAQanbWjtx9D303DUb3qkxBQFeJpOtmbt4i+MUQEXM70IgGQHlc7/Y6KJpPz5TRCS
         xibCTAoO8SUEYjr5y+vUxdcfuAE5P/vaZnhaFUFJ99Z2zEMKoU+DcnjEVYnjQ+FCft
         693j4xNl/UFL1GJTR+i9uR+5jN6YEjjv6AXN3YQYruieWpONb7qBtUmrMnmxxZXR8r
         7Vv3ycoVpUsMyC499+pKcLzqgrpEZlMoHpK0y/ubE7DgSPHHnbrKEZZCkN43f+LIxJ
         s7o1qgPUUqScFL4sZdVd8w0/dK2qps1jsb6oSqvoQAZzRDVA8POlGVn/1Cvj/nX3fR
         s591/ZmE3uSiA==
To:     Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
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
Message-ID: <OMOzHvru0iqQzq7rTSqJtI0P9wKSBLATuflwj10xgHvSgJ49V522CaDkIiZ0wWHJw-F5GPQxeO8cKO5ACMXggtDNlfx5TAa0zRObj7wsHHg=@emersion.fr>
In-Reply-To: <a8f02b4c-b1ea-320e-a6b2-952f4e641794@foss.st.com>
References: <20210707084557.22443-1-raphael.gallais-pou@foss.st.com> <31K3xupK1-7HNWorHqIwGwgEJl-1XdFjUQEoNYm6yB-lRoZ8kq5quRji_r3mzPZ0bUayLef6xPfQDiETgZp9lR7vUpDn2nB_37ncSd-J0Wc=@emersion.fr> <YOWTCSpOZTGZS2qP@phenom.ffwll.local> <a8f02b4c-b1ea-320e-a6b2-952f4e641794@foss.st.com>
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

On Friday, July 9th, 2021 at 11:09, Raphael Gallais-Pou <raphael.gallais-po=
u@foss.st.com> wrote:

> We don't usually test with piglit and igt-gpu-tools. Instead, modetest
> utility of the libdrm is used quite often (as is it the case in order to
> test this property).

Just to make it extra clear: regardless of how you bring up your driver
implementation, without an IGT test and real-world open-source user-space
patches that make use of the new prop, your patches *cannot* be merged.

If you're planning to add support for the new prop to an open-source KMS
client, please add a link to the patches in your kernel submission. If
you don't have plans to use the new prop in an open-source KMS client,
let us know and we can discuss what the best candidate would be.

> I was also thinking about implementing an option into modetest to ease
> the use of this drm property (support of hexadecimal values for propertie=
s).

(For the record, modeset doesn't count as a real-world user-space usage: it=
's
just a toy implementation, just a test tool.)

Simon
