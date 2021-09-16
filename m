Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4539140D468
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 10:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbhIPIYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 04:24:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49794 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234904AbhIPIYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 04:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631780575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QWt3ip4CBk0I1AL9OVGf26EzSToILsSmwhya6rje3aI=;
        b=U0kuVAxBD6giqI0kxDnorPZzFfvQVOSQBn2sXlu/PuuLW0qEZjSgfiobdZxpcbg6iypd09
        iEhqxJ0U9/Y0ucWJBskHpFjKnbgKLFR7NIax0yi4QRwSBdj7FODMobu7CKdPUck9cg8Djx
        FEAmqOa/T4IslsLxjlwkGip161RgBzI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-j50vqmdTPD6_xx3ZVhctiA-1; Thu, 16 Sep 2021 04:22:54 -0400
X-MC-Unique: j50vqmdTPD6_xx3ZVhctiA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B40950759;
        Thu, 16 Sep 2021 08:22:53 +0000 (UTC)
Received: from T590 (ovpn-12-89.pek2.redhat.com [10.72.12.89])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 42E22838DB;
        Thu, 16 Sep 2021 08:22:32 +0000 (UTC)
Date:   Thu, 16 Sep 2021 16:22:44 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     pkalever@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        nbd@other.debian.org, josef@toxicpanda.com, axboe@kernel.dk,
        idryomov@redhat.com, xiubli@redhat.com,
        Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
Subject: Re: [PATCH v1 1/2] block: cleanup: define default command timeout
 and use it
Message-ID: <YUL+1PE1z5aM0eTM@T590>
References: <20210806142914.70556-1-pkalever@redhat.com>
 <20210806142914.70556-2-pkalever@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806142914.70556-2-pkalever@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2021 at 07:59:13PM +0530, pkalever@redhat.com wrote:
> From: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
> 
> defined BLK_DEFAULT_CMD_TIMEOUT and reuse it everywhere else.
> 
> Signed-off-by: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
> ---

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

