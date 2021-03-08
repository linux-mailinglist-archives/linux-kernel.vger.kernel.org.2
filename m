Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537D733134B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 17:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhCHQXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 11:23:07 -0500
Received: from netrider.rowland.org ([192.131.102.5]:53247 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S230409AbhCHQW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 11:22:59 -0500
Received: (qmail 139795 invoked by uid 1000); 8 Mar 2021 11:22:58 -0500
Date:   Mon, 8 Mar 2021 11:22:58 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ikjoon Jang <ikjn@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>
Subject: Re: [PATCH v2 16/18] usb: common: add function to get interval
 expressed in us unit
Message-ID: <20210308162258.GA138835@rowland.harvard.edu>
References: <d287899e6beb2fc1bfb8900c75a872f628ecde55.1615170625.git.chunfeng.yun@mediatek.com>
 <25c8a09b055f716c1e5bf11fea72c3418f844482.1615170625.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25c8a09b055f716c1e5bf11fea72c3418f844482.1615170625.git.chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 10:52:05AM +0800, Chunfeng Yun wrote:
> Add a new function to convert bInterval into the time expressed
> in 1us unit.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2: move kerneldoc next to function's definition suggested by Alan
> ---
>  drivers/usb/common/common.c | 41 +++++++++++++++++++++++++++++++++++++
>  drivers/usb/core/devices.c  | 21 ++++---------------
>  drivers/usb/core/endpoint.c | 35 ++++---------------------------
>  include/linux/usb/ch9.h     |  3 +++
>  4 files changed, 52 insertions(+), 48 deletions(-)

Acked-by: Alan Stern <stern@rowland.harvard.edu>
