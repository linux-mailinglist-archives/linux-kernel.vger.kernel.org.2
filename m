Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BA53B0339
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 13:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhFVLvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 07:51:44 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:39422 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbhFVLvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 07:51:42 -0400
Date:   Tue, 22 Jun 2021 11:48:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail3; t=1624362533;
        bh=YdiN0pT6LyBBXp45IM63KSqansKLfPR5K/ejEZVcIBA=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=WbqU/TJmgJewteirDgKWtXUv0FH+QXBu1SHamMgLkS0HVsbvqLQ2nchnWmxn/xsnx
         TVww0VIqHVKCAsuXBu9w7KN/kF3V2QKJJ6faG/iwa2IRRkDBelS5R5wY5VCpbnNRyz
         Smk65uNzdhYkWBuvBq29T9kEPOzQEEDQLooOVaN+JEzw335DKSeu9hLrns0x7C0y3B
         6JRXTkaEnM5NnPx9qGwNEagF8keFI6+QbyKusJeQj4C+X9YT5LPQVSjn7vdEgOnwoj
         uTIkjev5CMGbJ+cmnNZsD5c543GUnYBYhTwqA/+cEWLGW4Zy+VKTgux6JqbqXFEzTA
         3LnjzwDkuj4hw==
To:     Werner Sembach <wse@tuxedocomputers.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     Pekka Paalanen <ppaalanen@gmail.com>, sunpeng.li@amd.com,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        amd-gfx@lists.freedesktop.org, tzimmermann@suse.de,
        rodrigo.vivi@intel.com, alexander.deucher@amd.com,
        christian.koenig@amd.com
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v4 09/17] drm/uAPI: Add "active color range" drm property as feedback for userspace
Message-ID: <k_QeCRpur3SNNIspBiTHOTT6Oj1pSteEO3MzyQFUG0lSXmEqJUI2tMXJ6wR9chzUHGahdQApJZrUxdJvIv6s8aXr2DBdoHg-2PsGH4kEMyA=@emersion.fr>
In-Reply-To: <56d079d4-841a-0ca5-b8a6-d2c10f91d211@tuxedocomputers.com>
References: <20210618091116.14428-1-wse@tuxedocomputers.com> <20210618091116.14428-10-wse@tuxedocomputers.com> <20210622100042.4041624a@eldfell> <56d079d4-841a-0ca5-b8a6-d2c10f91d211@tuxedocomputers.com>
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

On Tuesday, June 22nd, 2021 at 11:50, Werner Sembach <wse@tuxedocomputers.c=
om> wrote:

> Unknown is when no monitor is connected or is when the
> connector/monitor is disabled.

I think the other connector props (link-status, non-desktop, etc) don't
have a special "unset" value, and instead the value is set to a random
enum entry. User-space should ignore the prop on these disconnected
connectors anyways.
