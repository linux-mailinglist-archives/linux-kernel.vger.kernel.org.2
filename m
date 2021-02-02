Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C75D30C1E8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 15:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbhBBOfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 09:35:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51205 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234620AbhBBOe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 09:34:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612276382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MOfLz2ooS1YVxqAqeLs03INDucXpuqKyLYasthASKR4=;
        b=UERma3UKTpOegbcM6USO7RvqJT6o1WZKHH1W1Kn10cFUe8SGQi43Yg9IDAMCQzl2OqZbZ+
        IUovxp2eMpEgZI5ECZsnR8+Zf2sO5ZK24fle/+ym82euOD0aw8Lg1oLBpBI6AvlNiAtuhu
        rVw5wFRfKdsWNGcfevJ5XmRvMSUY+IU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-QGq7qQrGPZmiYRqNjGj6Aw-1; Tue, 02 Feb 2021 09:33:00 -0500
X-MC-Unique: QGq7qQrGPZmiYRqNjGj6Aw-1
Received: by mail-wr1-f69.google.com with SMTP id u3so12572871wri.19
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 06:33:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MOfLz2ooS1YVxqAqeLs03INDucXpuqKyLYasthASKR4=;
        b=Dm0B+r9DcO+qfjqBZjwvy047U69v4xfMDeg+vMaAQsOFyvuI+7Lxi2l7tFXpJeHXC2
         Tb/04suX87jfOXhBKT5Nc7ucMRCdZi1TSnsZt9Nt32gLnaExYfehClxW1VhxijBm3Efl
         tqwp2yHL56FIbnPP+MJOuWdEu7hCOxaheNjsX/6wqfO0DxS+Qja6C7LGtQgrwtDkMmpp
         eH+1J+79jGPFazqPGLIzIUxpNwi+luGYEvHeLPJm4tdsSa34ndw8wyOL4E9C2Lsjo6mZ
         IKUix7NpZU0OaLG2RTdzvch0/5cOYACQf9oTGor0WKQyv2XhlKX7Q9px2ubokJwmDAPh
         2mxQ==
X-Gm-Message-State: AOAM533fDrsrez3AX6vhlctTk4lpntWzNisM6DjbQZHJghpI0BEw8bsl
        8fRNQUhYhvbuUmEPL37QdVkubPTARuMAIFlseOBFQKzQUZx/OvrrJqtlLOfw2ZQ2UqMK2MnBW7D
        6EGaa/04yR6gN5sqhf+epTHOD
X-Received: by 2002:adf:d1cb:: with SMTP id b11mr24388392wrd.118.1612276379287;
        Tue, 02 Feb 2021 06:32:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzNlKeX+el7cMOrZK5yq6RtSBJMhNR+o0snQl4QXFgxLrVEgd3S6vtJXgCeHmPNLUWxDwZ7tg==
X-Received: by 2002:adf:d1cb:: with SMTP id b11mr24388360wrd.118.1612276379086;
        Tue, 02 Feb 2021 06:32:59 -0800 (PST)
Received: from redhat.com (bzq-79-177-39-148.red.bezeqint.net. [79.177.39.148])
        by smtp.gmail.com with ESMTPSA id b138sm3242759wmb.35.2021.02.02.06.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 06:32:54 -0800 (PST)
Date:   Tue, 2 Feb 2021 09:32:50 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Adrian Catangiu <acatan@amazon.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        gregkh@linuxfoundation.org, graf@amazon.com, arnd@arndb.de,
        ebiederm@xmission.com, rppt@kernel.org, 0x7f454c46@gmail.com,
        borntraeger@de.ibm.com, Jason@zx2c4.com, jannh@google.com,
        w@1wt.eu, colmmacc@amazon.com, luto@kernel.org, tytso@mit.edu,
        ebiggers@kernel.org, dwmw@amazon.co.uk, bonzini@gnu.org,
        sblbir@amazon.com, raduweis@amazon.com, corbet@lwn.net,
        mhocko@kernel.org, rafael@kernel.org, mpe@ellerman.id.au,
        areber@redhat.com, ovzxemul@gmail.com, avagin@gmail.com,
        ptikhomirov@virtuozzo.com, gil@azul.com, asmehra@redhat.com,
        dgunigun@redhat.com, vijaysun@ca.ibm.com, oridgar@gmail.com,
        ghammer@redhat.com
Subject: Re: [PATCH v4 1/2] drivers/misc: sysgenid: add system generation id
 driver
Message-ID: <20210202092418-mutt-send-email-mst@kernel.org>
References: <1610453760-13812-1-git-send-email-acatan@amazon.com>
 <1610453760-13812-2-git-send-email-acatan@amazon.com>
 <20210127221505.GB24799@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127221505.GB24799@amd>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 11:15:05PM +0100, Pavel Machek wrote:
> Hi!
> 
> > - Solution
> > 
> > The System Generation ID is a simple concept meant to alleviate the
> > issue by providing a monotonically increasing u32 counter that changes
> > each time the VM or container is restored from a snapshot.
> 
> I'd make it u64.
> 
> But as people explained, this has race problems that may be impossible
> to solve?

Well the read/write interface could be used in a safe way thinkably:

- application checks VM gen id
- application sends a transaction e.g. to  database
- application re-checks VM gen id
- if id changed, application checks the database for duplicate
  transactions

not sure how can the mmap interface be used safely.
Drop it for now?



> Best regards,
> 								Pavel
> 								
> -- 
> http://www.livejournal.com/~pavelmachek


