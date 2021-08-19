Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD283F1C48
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 17:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239972AbhHSPLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 11:11:07 -0400
Received: from smtprelay0182.hostedemail.com ([216.40.44.182]:39118 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238460AbhHSPLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 11:11:06 -0400
Received: from omf19.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id AE46D26DD3;
        Thu, 19 Aug 2021 15:10:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id B4AEE20D772;
        Thu, 19 Aug 2021 15:10:24 +0000 (UTC)
Message-ID: <930fbf0e3b17a78c64a32d26fcf9aed46c5d6d88.camel@perches.com>
Subject: Re: [PATCH] drm/bridge/tc358767: make the array ext_div static
 const, makes object smaller
From:   Joe Perches <joe@perches.com>
To:     Colin Ian King <colin.king@canonical.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 19 Aug 2021 08:10:23 -0700
In-Reply-To: <c4378876-74b0-4f80-05b7-dcd809bb47a1@canonical.com>
References: <20210819133839.10745-1-colin.king@canonical.com>
         <0a2ea4e54d7bfd61b45cc070eee6b62e8da82190.camel@perches.com>
         <913b96bc-f5c4-1a26-c5f7-70a9d0ab3f53@canonical.com>
         <3da667b1b415b19325c034dcb389a201fa46cfd3.camel@perches.com>
         <c4378876-74b0-4f80-05b7-dcd809bb47a1@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.99
X-Stat-Signature: dwmfzc5xuegxfms4xm4a7wiw1xyirjk8
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: B4AEE20D772
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/I4h/4/Jwrq9yDdzp3ajPSpHN+nWw4Yzk=
X-HE-Tag: 1629385824-254300
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-08-19 at 15:51 +0100, Colin Ian King wrote:

> it still makes sense for these kind of
> janitorial changes as it makes sense to constify arrays when they are
> read-only and making them static is sensible for const data.

I'm not disagreeing. Marking unmodifiable arrays as const is generally
useful for readers.  Decent compilers though can _mostly_ determine
whether or not an array is used as const and whether the array can be
placed in a readonly section and is not required to be in a writable one.

But the object sizes deltas you show with an allmodconfig are misleading.
At a minimum I think you should show the output sizes as allmodconfig.


