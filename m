Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747573BBAF4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 12:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhGEKSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 06:18:37 -0400
Received: from verein.lst.de ([213.95.11.211]:56389 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230355AbhGEKSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 06:18:34 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C7A9968B05; Mon,  5 Jul 2021 12:15:54 +0200 (CEST)
Date:   Mon, 5 Jul 2021 12:15:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     shiva.linuxworks@gmail.com
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: Re: [PATCH] nvme: Add abrupt shutdown support
Message-ID: <20210705101554.GA12803@lst.de>
References: <20210705101157.1009135-1-sshivamurthy@micron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705101157.1009135-1-sshivamurthy@micron.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2021 at 10:11:57AM +0000, shiva.linuxworks@gmail.com wrote:
> From: Shivamurthy Shastri <sshivamurthy@micron.com>
> 
> Enabling the abrupt shutdown support. In this shutdown type host does
> not need to send Delete I/O Submission Queue and Delete I/O Completion
> queue commands to the device.

Why?
