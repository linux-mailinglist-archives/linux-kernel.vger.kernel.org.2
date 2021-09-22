Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229F8414968
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 14:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236028AbhIVMsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 08:48:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235227AbhIVMsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 08:48:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5732660F13;
        Wed, 22 Sep 2021 12:46:36 +0000 (UTC)
Date:   Wed, 22 Sep 2021 14:46:34 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     hdanton@sina.com, hch@infradead.org, stefanha@redhat.com,
        jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 4/9] fork: add option to not clone or dup files
Message-ID: <20210922124634.zodjcbvksdkhjrym@wittgenstein>
References: <20210921215218.89844-1-michael.christie@oracle.com>
 <20210921215218.89844-5-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210921215218.89844-5-michael.christie@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 04:52:13PM -0500, Mike Christie wrote:
> Each vhost device gets a thread that is used to perform IO and management
> operations. Instead of a thread that is accessing a device, the thread is
> part of the device, so when it calls the kernel_worker() function added in
> the next patch we can't dup or clone the parent's files/FDS because it would
> do an extra increment on ourself.
> 
> Later, when we do:
> 
> Qemu process exits:
>         do_exit -> exit_files -> put_files_struct -> close_files
> 
> we would leak the device's resources because of that extra refcount
> on the fd or file_struct.
> 
> This patch adds a no_files option so these worker threads can prevent
> taking an extra refcount on themselves.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>

Ok,
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
