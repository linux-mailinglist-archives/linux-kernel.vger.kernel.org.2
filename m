Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEC343E32A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 16:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbhJ1OMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 10:12:14 -0400
Received: from mail-4022.proton.ch ([185.70.40.22]:12074 "EHLO
        mail-4022.proton.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbhJ1OMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 10:12:13 -0400
Date:   Thu, 28 Oct 2021 14:09:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1635430184;
        bh=sfjvhnOlQn80OqnZTv0gYWgB7med55eS3xYGH2ls3VE=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=EP1gCbnZShgu/GPwsJ8WVRZICz0Jz9E8IUzu3I/MevB20iYyP2TIdhQ9qY5YI44WB
         R64aqJ2Y9Cil+LzIM3t5Cr0ecNjpZNlkrjsnPfLlLLbqpOO+VzxMUYT+lnAeRkAGHA
         xlxCA6s28mWKPq+6qjgnZ7q3U8A6belIR+nxXCR893ijivnfThWXHDhGQIYE7458LT
         oZCsaOKYf3cBP0fE6ux1QBJooH2bnLRct5dH5Yzq4Pr5OC299oyO4nm42JVMfMBIs2
         p6f4pM7uskWoARQaWdY32+pzVsiLbWpeGPn+Os7II7e6Vc1Hkl3qsDb1U93datg9uu
         xlPyfhn0RB9dA==
To:     George Kennedy <george.kennedy@oracle.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     gregkh@linuxfoundation.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH] drm: check drm_format_info hsub and vsub to avoid divide by zero
Message-ID: <8hH-kEJ_5Fp13IJG-WuzuXJ9cXjNaigTbD0yHYmgmOCk8WmJpZr4pd2zeDwdOiMrPxxyseNzRnSel5e2OOwzF8HPPaoQJWva-EgVF7xy3-k=@emersion.fr>
In-Reply-To: <1635429437-21718-1-git-send-email-george.kennedy@oracle.com>
References: <1635429437-21718-1-git-send-email-george.kennedy@oracle.com>
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

Maybe a self-test checking this would be more appropriate?
