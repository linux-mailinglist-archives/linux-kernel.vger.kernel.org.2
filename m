Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39077327A85
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 10:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbhCAJNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 04:13:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:40610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233360AbhCAJN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 04:13:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F2B464DD0;
        Mon,  1 Mar 2021 09:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614589968;
        bh=tjkiVI3A2xFgGl10IYM9My8bIQDSmWhGcqwupcCBLZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KpRyLJX904gVPbkb9OPq4D7rLPnXwN7CCokueIjgnPV9eOuINJFzE5wdKAdb7elm4
         TLlsCMvA4JLzD4tQxC37Oo5NmsQsQnGz1dVPwsl+HQGCnHzNi4g624llR51RdVwWu6
         o7gJVmk5W7trKXGdSvrWtlh3IgppHwSIT9FNkkOVYIfs65t3p/ZOp/Eq2+Ne1tckmo
         m/iDXwuq8WzCeyIF8IGZPM4AHu748X68tKt/sTrnLdymlZemkzEgNaGGwWA8FEZXXj
         FOF5GIrWPECsf0tT88pdz/a/yeCEjBzLkyMlm9pfI2JJsQvYyLnAHOWwJiHMrmNxWA
         9rqrjB/NUg81Q==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lGebx-0006tK-6u; Mon, 01 Mar 2021 10:13:05 +0100
Date:   Mon, 1 Mar 2021 10:13:05 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Karan Singhal <karan.singhal@acuitybrands.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] USB: serial: cp210x: add IDs for nLight Air Adapter,
 Acuity Brands, Inc.
Message-ID: <YDywIaupI5YRLw8/@hovoldconsulting.com>
References: <20210216160310.6144-1-karan.singhal@acuitybrands.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210216160310.6144-1-karan.singhal@acuitybrands.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 11:03:10AM -0500, Karan Singhal wrote:
> IDs of nLight Air Adapter, Acuity Brands, Inc.:
> vid: 10c4
> pid: 88d8
> 
> Signed-off-by: Karan Singhal <karan.singhal@acuitybrands.com>
> ---

Next time when amending a patch, please include a changelog here so we
know what changes between revisions.

Now applied, thanks.

Johan
