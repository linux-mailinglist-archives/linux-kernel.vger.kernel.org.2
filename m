Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B6F414945
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 14:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235970AbhIVMqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 08:46:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235227AbhIVMqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 08:46:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EFEB8610A0;
        Wed, 22 Sep 2021 12:44:42 +0000 (UTC)
Date:   Wed, 22 Sep 2021 14:44:40 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     hdanton@sina.com, hch@infradead.org, stefanha@redhat.com,
        jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/9] fork: Make IO worker options flag based
Message-ID: <20210922124440.2jndok5s6wym6h2d@wittgenstein>
References: <20210921215218.89844-1-michael.christie@oracle.com>
 <20210921215218.89844-2-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210921215218.89844-2-michael.christie@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 04:52:10PM -0500, Mike Christie wrote:
> This patchset adds a couple new options to kernel_clone_args for IO thread
> like/related users. Instead of adding new fields to kernel_clone_args for
> each option, this moves us to a flags based approach by first converting
> io_thread.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>

Looks good.
Suggested-by: Christian Brauner <christian.brauner@ubuntu.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
