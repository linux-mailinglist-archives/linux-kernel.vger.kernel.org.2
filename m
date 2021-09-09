Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29DA2405915
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 16:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236551AbhIIOcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 10:32:54 -0400
Received: from netrider.rowland.org ([192.131.102.5]:57051 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S242587AbhIIOct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 10:32:49 -0400
Received: (qmail 638642 invoked by uid 1000); 9 Sep 2021 10:31:38 -0400
Date:   Thu, 9 Sep 2021 10:31:38 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        chris.chiu@canonical.com, lokeshvutla@ti.com
Subject: Re: [PATCH v4 1/3] usb: core: hcd: Add support for deferring roothub
 registration
Message-ID: <20210909143138.GA638029@rowland.harvard.edu>
References: <20210909064200.16216-1-kishon@ti.com>
 <20210909064200.16216-2-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909064200.16216-2-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 12:11:58PM +0530, Kishon Vijay Abraham I wrote:
> It has been observed with certain PCIe USB cards (like Inateck connected
> to AM64 EVM or J7200 EVM) that as soon as the primary roothub is
> registered, port status change is handled even before xHC is running
> leading to cold plug USB devices not detected. For such cases, registering
> both the root hubs along with the second HCD is required. Add support for
> deferring roothub registration in usb_add_hcd(), so that both primary and
> secondary roothubs are registered along with the second HCD.
> 
> CC: stable@vger.kernel.org # 5.4+
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Suggested-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> Tested-by: Chris Chiu <chris.chiu@canonical.com>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>
