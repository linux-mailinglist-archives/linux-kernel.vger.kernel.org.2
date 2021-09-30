Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F6541D783
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 12:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349867AbhI3KT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 06:19:27 -0400
Received: from mail-4322.protonmail.ch ([185.70.43.22]:54845 "EHLO
        mail-4322.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349856AbhI3KTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 06:19:15 -0400
Date:   Thu, 30 Sep 2021 10:17:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1632997050;
        bh=omu6kUN/ZbjN/MA32O0UnYTGse061XaoIw5SVvXsMJg=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=kFLPl7HPxuXTisHVHRjo3tmjECLclF4sbz9BepfxOoj+K+F3V6xyK+RCwvy4v8zLY
         CUadODmeZxu+MWJsdu6xVmzimRpEfHQQbP+4IAtabwp9Y106PoqMvngC0QmY4kVW4I
         DKE9KzxLLNtMZcjOka56mhNvJQSkEwM7ddIhrNxJCWyZtEhcMixRZ30ufpj0PkAdtT
         LgTLVOKJ/wv5O1TW1ip1u4D0qQZgizRv6MBbKf/Q07JShMJzgufNX8HkCRCTFvyilB
         v8Gq+JBb0AY9bPx4nxZgo5G0baPoy88aluPiK6d7YuDxqRmZHcg9y8SDR+WHCkPts2
         GzjrPYCFQs0rg==
To:     Guo Zhengkui <guozhengkui@vivo.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Guchun Chen <guchun.chen@amd.com>,
        Peng Ju Zhou <PengJu.Zhou@amd.com>,
        Bokun Zhang <Bokun.Zhang@amd.com>,
        Likun GAO <Likun.Gao@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@vivo.com
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH] drm/amdgpu: fix some repeated includings
Message-ID: <AGiYadRf5XyGUqLxwu3ykKzfwM2BgZo4yCAaEXdQiYfH2dbyKmipDNrclnI2lZH3HzNh71VBy5QKz3O4fFvQETjTI9hoKzKHjZNBz9ERKI8=@emersion.fr>
In-Reply-To: <20210930094239.7435-1-guozhengkui@vivo.com>
References: <20210930094239.7435-1-guozhengkui@vivo.com>
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

One include is v2, the other is v3, or am I missing something?
