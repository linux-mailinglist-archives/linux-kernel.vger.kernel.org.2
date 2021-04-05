Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11BA3353C26
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 09:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbhDEHEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 03:04:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232313AbhDEHEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 03:04:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7A4561398;
        Mon,  5 Apr 2021 07:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617606244;
        bh=ezlnbhg/LsgwTLJp3Hxyw3QKTpzBOGY8S1cj+nKb3gc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ygYsoHbwuRygjVW1EKRcogwgUih7oFsLilNnNuJEb5yA8vxhPU+JPMCK5BUm7pu6/
         zFrOCGKpaRTyLqoih2xB0SnF1mxdnJkBJRJFSnfC9lWuDJwO3WMDNXZ0aJ72W/je3Y
         UeEiEJ2WMRL2lRoqLd09xkulR791BJEtQ4m1cuoo=
Date:   Mon, 5 Apr 2021 09:04:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Ikjoon Jang <ikjn@chromium.org>, Yaqii Wu <Yaqii.Wu@mediatek.com>,
        linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] usb: xhci-mtk: remove unnecessary assignments in
 periodic TT scheduler
Message-ID: <YGq2YfURFApdJLxb@kroah.com>
References: <20210330080617.3746932-1-ikjn@chromium.org>
 <20210330160508.1.I797d214790033d0402d19ff6b47a34aff60d3062@changeid>
 <1617179455.2752.1.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617179455.2752.1.camel@mhfsdcap03>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 04:30:55PM +0800, Chunfeng Yun wrote:
> cc Yaqii Wu <Yaqii.Wu@mediatek.com>
> 
> I'll test it , thanks

Did you test this series and find any problems?  If not, I'll go queue
these up...

thanks,

greg k-h
