Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0299239FCC0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 18:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbhFHQrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 12:47:45 -0400
Received: from smtprelay0077.hostedemail.com ([216.40.44.77]:54426 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232807AbhFHQro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 12:47:44 -0400
Received: from omf11.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 1C1E7181D3042;
        Tue,  8 Jun 2021 16:45:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id 5128B20A299;
        Tue,  8 Jun 2021 16:45:50 +0000 (UTC)
Message-ID: <b77a3e7b0923344e8c5b9b17f4788d28f3ccfb4f.camel@perches.com>
Subject: Re: [PATCH -next 2/2] staging: r8188eu: use eth_broadcast_addr() to
 assign broadcast address
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liu Shixin <liushixin2@huawei.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Tue, 08 Jun 2021 09:45:49 -0700
In-Reply-To: <YL96vz4okNehxCBG@kroah.com>
References: <20210608141620.525521-1-liushixin2@huawei.com>
         <YL96vz4okNehxCBG@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.32
X-Stat-Signature: p9wydgr8pharduzuarqe1ngfenzwejnj
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 5128B20A299
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/YiXAixKRd9sc3PQad8sltguXjxgVCQV8=
X-HE-Tag: 1623170750-172711
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-06-08 at 16:12 +0200, Greg Kroah-Hartman wrote:
> On Tue, Jun 08, 2021 at 10:16:20PM +0800, Liu Shixin wrote:
> > Use eth_broadcast_addr() to assign broadcast address.
> 
> That says what you do, but not _why_ you are doing this?
> 
> Why make this change?  What benifit does it provide?

The commit message is clear and concise as using available kernel
mechanisms is better than homegrown or duplicative ones.

Are you asking merely becuse Liu Shixin hasn't had many staging
commits?



