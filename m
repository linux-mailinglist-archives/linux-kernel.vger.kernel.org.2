Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8B03A7804
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 09:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhFOHeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 03:34:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:54936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229960AbhFOHd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 03:33:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33558610CD;
        Tue, 15 Jun 2021 07:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623742314;
        bh=ZlXc5W78HT/qeKUBCNPdLYEw60p6+TEr5N4RNmuqwDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eiDHLHluE4j5jJyBU80fR6n3aJwc8N2BcLMvKed7YBpPL1o/QjcCcDbKZJMihMl9V
         VCYYvkVdKZhEI/tb2CfepH7MrpCx1RR4QCFlGFx+yTQBTSs2SS627gASwPQPmTkFCG
         d3VE8MFeGORW1oZtpcTUOPSJfFYPQ4whwlJ5ElCE=
Date:   Tue, 15 Jun 2021 09:31:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] coresight: Patches for v5.14
Message-ID: <YMhXaIIhtli4mRQa@kroah.com>
References: <20210614175901.532683-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614175901.532683-1-mathieu.poirier@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 11:58:55AM -0600, Mathieu Poirier wrote:
> Good day Greg,
> 
> A small tally this time around - there might be a part 2 but that is not
> clear at the moment.  Applies cleanly on today's char-misc-next
> (db4e54aefdfe).

For some reason I got patch 0/6 3 times, but I've only applied this
series once :)
