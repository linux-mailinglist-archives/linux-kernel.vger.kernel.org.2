Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817E23F83B9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 10:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240434AbhHZI0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 04:26:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:41820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236028AbhHZI0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 04:26:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 181D460C51;
        Thu, 26 Aug 2021 08:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629966331;
        bh=JVcz86aSIfR1c776e4pmHcBkiC837bCEcJgQy0+9FVY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yecfs/iexOOLJlQ5ToUKKGOOQIhN+9N3YvECPTtl5mYxAlF3+ER2pcOSPSZuQmeNA
         htsxvzU91EF3BUQCWZ1IOaVBfFKWv2FIyNn1zEHp7Ro5U5ydZcwq1URJOdOIQyRoWH
         CdGXY41yNLYRVeVSrSKrvESrXqvZxDs4aQSBanqE=
Date:   Thu, 26 Aug 2021 10:25:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     torvic9@mailbox.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Question] 5.14-rc7 not in stable tree?
Message-ID: <YSdP99/bBlF3DL5n@kroah.com>
References: <711627393.145278.1629789834855@office.mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <711627393.145278.1629789834855@office.mailbox.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 09:23:54AM +0200, torvic9@mailbox.org wrote:
> Hello,
> 
> is it normal that 5.14-rc7 is not available in the master
> branch of kernel/git/stable/linux.git?
> Master is still at rc6, just wondering.

This should now be fixed.
