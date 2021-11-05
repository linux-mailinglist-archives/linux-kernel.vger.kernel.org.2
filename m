Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128524466CC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 17:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbhKEQQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 12:16:33 -0400
Received: from mga05.intel.com ([192.55.52.43]:16435 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231720AbhKEQQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 12:16:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10159"; a="318131377"
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="318131377"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 09:07:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="639860271"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 05 Nov 2021 09:07:37 -0700
To:     "Walt Jr. Brake" <mr.yming81@gmail.com>
Cc:     chunfeng.yun@mediatek.com, matthias.bgg@gmail.com,
        nishadkamdar@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, eddie.hung@mediatek.com,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg KH <gregkh@linuxfoundation.org>
References: <20211105133050.GA1590803@rowland.harvard.edu>
 <20211105160036.549516-1-mathias.nyman@linux.intel.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH] xhci: Fix USB 3.1 enumeration issues by increasing
 roothub power-on-good delay
Message-ID: <96925c96-0f87-f110-e279-5b669337948a@linux.intel.com>
Date:   Fri, 5 Nov 2021 18:09:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211105160036.549516-1-mathias.nyman@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5.11.2021 18.00, Mathias Nyman wrote:
> Some USB 3.1 enumeration issues were reported after the hub driver removed
> the minimum 100ms limit for the power-on-good delay.
> 
> Since commit 90d28fb53d4a ("usb: core: reduce power-on-good delay time of
> root hub") the hub driver sets the power-on-delay based on the
> bPwrOn2PwrGood value in the hub descriptor.
> 
> xhci driver has a 20ms bPwrOn2PwrGood value for both roothubs based
> on xhci spec section 5.4.8, but it's clearly not enough for the
> USB 3.1 devices, causing enumeration issues.
> 
> Tests indicate full 100ms delay is needed.
> 
> Reported-by: Walt Jr. Brake <mr.yming81@gmail.com>
> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> 

Walt Jr Brake, just to be sure could you test this one as well?

As Alan suggested this sets 100ms for the USB 3 roothub but
keeps the 20ms for the USB 2 roothub.

Thanks
-Mathias 
