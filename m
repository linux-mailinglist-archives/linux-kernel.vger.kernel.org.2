Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACF23FB9C0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 18:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237949AbhH3QHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 12:07:11 -0400
Received: from mail-40131.protonmail.ch ([185.70.40.131]:47690 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237899AbhH3QHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 12:07:10 -0400
Date:   Mon, 30 Aug 2021 16:06:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1630339575;
        bh=6BtEWVe5hUeab8q8CCkZgYLqgz9PL4mbc3f0l6qdXAo=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=EeAOOX03lkc7k3EXPRBQonyTQS5/D7GQLTZp5QwNvHUocDNirfXUfWQFLSwhoySoC
         5Fg6AP4pApoG1XNBS/UMDK+UHrDjHk5OUJCdMrfhQGi31r43exHSHEN0E06iPtY5he
         9OL3ev6CCxJgcuBisu39/+LFjeoxSp8T3wSoB1t19R484Fy76DhKCWvOt0HgDEm1P5
         7uX7wX1UOaf4X3xTtJNT5gswy0bAhYhHeOpYqildTkZYKvJeD0F+KAvVv8eiNfJo5P
         VhrwLTOeWSZP0p1z6uHqn2ocU/oqwbhLe8HKJefdV5tztwhdQCnF9wEOPsUnJIYG2J
         bRwgZKB1X9ovA==
To:     "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>
From:   Simon Ser <contact@emersion.fr>
Cc:     airlied@redhat.com, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v2] GPU:DRM: returning ENOMEM
Message-ID: <Fcjg562QO6IVEH6CeOsulpchEyhg3JBRlvZ82YlQbbccdvUXMuShJFaxdWQDAhzgiMnajVDv7STloW0YuQniJE1cy4izlJz9zvSWs551gxg=@emersion.fr>
In-Reply-To: <20210830160207.23936-1-asha.16@itfac.mrt.ac.lk>
References: <20210828154027.8198-1-asha.16@itfac.mrt.ac.lk> <20210830160207.23936-1-asha.16@itfac.mrt.ac.lk>
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

Maybe the commit message can be improved a bit? Add a prefix to make it
clear this is about the udl driver, make it clear this is about the
udl_get_edid_block function. The new `return ret` statement may return
something different from ENOMEM.

This would give something among these lines:

    drm/udl: return -errno in udl_get_edid_block
