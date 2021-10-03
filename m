Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5916B420384
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 20:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbhJCS75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 14:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbhJCS74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 14:59:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C798C0613EC;
        Sun,  3 Oct 2021 11:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=ecCDp627k9b9pWiUjQNYfJsy6FQv77EM/XdnXbwKgjQ=; b=NPY5CsU2M8622V7qoLyh30jnp/
        aALbMv9f8bzLpVZGVUGLEQWSkbqmVmn8yt6JZ5PjsknQN2apeaNzx5XvJBkMT3Wa7t+b/KmlHpYyx
        1Thncj3fTmzLAD2MYzNtPui9i9iKP/Kp6HMOvAxGUup/1KZw2TRZtfGJfusyXjXeJ3Gm52imzpuWi
        oCONCoJQrcD0IK89gEjpQoxkBJvEb/gotk32TFkaxWl4D91/N05fH3yST7tcbM7jLscNj2/JTSP1H
        fYyPK9DdZpDj3Oa15dWgKzcZBYPp1raSjRaJJEe07M5lrFjiHZczgcuhCB2c3I77zVESzUpBBvP00
        gR3ADrOQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mX6gZ-004HYv-M0; Sun, 03 Oct 2021 18:58:07 +0000
Subject: Re: [PATCH 1/2] docs: dt: Fix a few grammar nits in the
 binding/schema docs
To:     Simon Glass <sjg@chromium.org>, devicetree@vger.kernel.org
Cc:     U-Boot Mailing List <u-boot@lists.denx.de>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org
References: <20211003124936.1.Idc7beddc77250bca0cfb5912b56be719d9073bc4@changeid>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a17737b2-b7aa-3e3a-d06d-fb70487f457a@infradead.org>
Date:   Sun, 3 Oct 2021 11:58:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211003124936.1.Idc7beddc77250bca0cfb5912b56be719d9073bc4@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/21 11:50 AM, Simon Glass wrote:
> Add missing hyphens and reword one sentence for clarity.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   .../devicetree/bindings/example-schema.yaml   | 14 ++++-----
>   .../devicetree/bindings/writing-bindings.rst  |  2 +-
>   .../devicetree/bindings/writing-schema.rst    | 29 ++++++++++---------
>   3 files changed, 23 insertions(+), 22 deletions(-)
> 

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.
-- 
~Randy
