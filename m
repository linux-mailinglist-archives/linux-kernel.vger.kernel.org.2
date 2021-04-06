Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890B5355AB4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 19:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347097AbhDFRrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 13:47:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32361 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233460AbhDFRrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 13:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617731254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XUAocMzqslhmkOUnlXNCrYEu99Q+VPwXt4fF/IrMZzk=;
        b=Gui9PRNaQkpTa/n5KCxkmwHwn9M3mKVIJIb6EXTfF9lj87yFYOBIs+S0RaCH77pF9LL73Y
        SDo5P/tqEAfLIdcf5zXvlHhWWn1dx/E/O8hYDwUFz/ab6JoJsN4LSafVVPU+D56Xuui/Ft
        w1A9bJahhciuigI9ktEzcf77kd+hYt4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-570-O_U_PLNVPqyZc9UocJRI5w-1; Tue, 06 Apr 2021 13:47:32 -0400
X-MC-Unique: O_U_PLNVPqyZc9UocJRI5w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE8E4839A42;
        Tue,  6 Apr 2021 17:47:31 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.43])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2460350A98;
        Tue,  6 Apr 2021 17:47:30 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  6 Apr 2021 19:47:31 +0200 (CEST)
Date:   Tue, 6 Apr 2021 19:47:30 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] task_work: add helper for more targeted task_work
 canceling
Message-ID: <20210406174729.GC13270@redhat.com>
References: <b036dde8-d025-5a9e-6a4c-60b4ce2d47b2@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b036dde8-d025-5a9e-6a4c-60b4ce2d47b2@kernel.dk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04, Jens Axboe wrote:
>
> +struct callback_head *task_work_cancel_match(struct task_struct *task,
> +	bool (*match)(struct callback_head *, void *data), void *data);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Feel free to ignore, but how about "typedef task_work_match_t" ?

Either way,

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

