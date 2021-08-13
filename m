Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85923EB37A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 11:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239637AbhHMJoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 05:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239028AbhHMJof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 05:44:35 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D53C061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 02:44:08 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1mETjN-0002KO-Tj; Fri, 13 Aug 2021 11:44:01 +0200
Date:   Fri, 13 Aug 2021 11:44:01 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] staging: r8188eu: refactor Hal_GetChnlGroup88E()
Message-ID: <20210813094401.y2d6wehhdtuvbvp4@viti.kaiser.cx>
References: <20210813073109.25609-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813073109.25609-1-straube.linux@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Michael Straube (straube.linux@gmail.com):

> This series refactors Hal_GetChnlGroup88E().
>  - removes 5GHz code
>  - changes return type to void
>  - cleans up camel case naming

> Michael Straube (4):
>   staging: r8188eu: remove 5GHz code from Hal_GetChnlGroup88E()
>   staging: r8188eu: convert return type of Hal_GetChnlGroup88E() to void
>   staging: r8188eu: rename parameter of Hal_GetChnlGroup88E()
>   staging: r8188eu: rename Hal_GetChnlGroup88E()

>  .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 90 ++++++-------------
>  1 file changed, 26 insertions(+), 64 deletions(-)

> -- 
> 2.32.0

Hi Michael,

this series looks ok to me.

Acked-by: Martin Kaiser <martin@kaiser.cx>
