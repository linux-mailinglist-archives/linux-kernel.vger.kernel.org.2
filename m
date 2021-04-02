Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2671A352B79
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 16:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbhDBO33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 10:29:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235608AbhDBO30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 10:29:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8FC9C610CB;
        Fri,  2 Apr 2021 14:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617373765;
        bh=qpDhJEeHPyYFSal/fdZKQpobnbC/xXGjO0fQUwpJxRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TLZHy7IZc7c7MpRS8tK5JWbpvy2iDevcaMSa3v0ZRG1tF5yGxrLHvffB5Nn4SLGDa
         4Y6cRWQ3Jvw+hv69OQq+sMySbEI15GJAhHRru/pPMiedz1VemQPyzqaxOaCkjoAvLk
         EoORgApUM/bq0oXQpjV349HRUONKDrnHL6BkBANA=
Date:   Fri, 2 Apr 2021 16:29:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] mux: gpio: Use bitmap API instead of direct
 assignment
Message-ID: <YGcqPMa9g/4etNO0@kroah.com>
References: <20210330193325.68362-1-andriy.shevchenko@linux.intel.com>
 <983be0af-d4dd-2873-ce63-1c7644b81bac@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <983be0af-d4dd-2873-ce63-1c7644b81bac@axentia.se>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 09:12:45AM +0200, Peter Rosin wrote:
> Hi Greg,
> 
> You can pick this series directly, right? I don't feel a compelling need to
> add the patches to -next before you take them since they are simple enough...

All now sucked in, thanks.

greg k-h
