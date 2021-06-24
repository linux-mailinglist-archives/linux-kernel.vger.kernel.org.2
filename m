Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372C93B295B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 09:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbhFXHgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 03:36:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47560 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231386AbhFXHga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 03:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624520051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+3ri02JcikUDdV3zELjIjJ7m7hQSA/GaXJn3H8LLNW4=;
        b=dQN9bN5E6DnCQ+3n8KV9mDo9IyBVgnaxrnXbgjodpyyt+zP9/HS89D6eJZMBQOZq9w+tlW
        UdFoq/pABKcRld8A3yfQtX0VvgcakD4sdjjOSk+od1XG7G6f5rNnj2cAmkwGd6EW89muWQ
        UQX+adEpZNuZhqobmOwTaRHMuadnQFo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-9GemgKdONXyE0uv7pzLhYA-1; Thu, 24 Jun 2021 03:34:09 -0400
X-MC-Unique: 9GemgKdONXyE0uv7pzLhYA-1
Received: by mail-ed1-f71.google.com with SMTP id ee28-20020a056402291cb0290394a9a0bfaeso2862936edb.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 00:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+3ri02JcikUDdV3zELjIjJ7m7hQSA/GaXJn3H8LLNW4=;
        b=ZFAzSRkXXMR0izfOozD+6r1gmNJ/0nWGdwMWM+Zl8ADJoU5vdgZWgpCpSQbCVAJc3D
         s+9hHruyZRsho/wFca0B7QB4FQnSQRVA3D+wf03hYylSCJ+sOJEHE7e+ivTKBldNhI+f
         2OteiV2rQhxoKeSmX2FLnC/4Kn2OtWmsFqq6E+7/Ea5sKTIXUM/PzEHrY7+c2Va3R9j3
         yfIgnZ2zDYC0wUpTdnNz4J+bWZCg+adZTKzU6Ygv77fLjhcQkwD47QLKlc2hfRv3FGi2
         AISZmd1D9MTfow0xmxHoDrCnWpB+UeYRVcobkBfZsOHyRBEJnTRILSyJTGYnQYa7yoJe
         hOMw==
X-Gm-Message-State: AOAM531aQL15qaGlMSnEMoQQn85GZ/rI1mnLNlekGewYT/qp1EGHcpZa
        zuppTnNFHGjTDCotXyhIDe9JXiS7dRc4prpgPpg1/O5n2puWI1NI+1nok4O0vcfktjtJm7Qcpee
        O5mSN2lpxsTzX9X1C86hmRNZ/
X-Received: by 2002:a17:906:c2cf:: with SMTP id ch15mr3910280ejb.517.1624520048496;
        Thu, 24 Jun 2021 00:34:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+LNv+c+e63ctYoEu2+THRGxPAm1rIotbbKIkGTW3lDLlJSyqxHRcZeEfzuNc1tYMo/AE2Qw==
X-Received: by 2002:a17:906:c2cf:: with SMTP id ch15mr3910269ejb.517.1624520048331;
        Thu, 24 Jun 2021 00:34:08 -0700 (PDT)
Received: from redhat.com ([77.124.79.210])
        by smtp.gmail.com with ESMTPSA id l7sm1348002edc.78.2021.06.24.00.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 00:34:07 -0700 (PDT)
Date:   Thu, 24 Jun 2021 03:34:04 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, sgarzare@redhat.com,
        jasowang@redhat.com, stefanha@redhat.com, christian@brauner.io,
        akpm@linux-foundation.org, peterz@infradead.org,
        christian.brauner@ubuntu.com
Subject: Re: [PATCH 0/3] kthread: pass in user and check RLIMIT_NPROC
Message-ID: <20210624033350-mutt-send-email-mst@kernel.org>
References: <20210624030804.4932-1-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624030804.4932-1-michael.christie@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 10:08:01PM -0500, Mike Christie wrote:
> The vhost driver will create a kthread when userspace does a
> VHOST_SET_OWNER ioctl, but the thread is charged to the kthreadd thread.
> We can then end up violating the userspace process's RLIMIT_NPROC. This
> patchset allows drivers to pass in the user to charge/check.
> 
> The patches were made over Linus's current tree.
> 


Makes sense I guess.

Acked-by: Michael S. Tsirkin <mst@redhat.com>

