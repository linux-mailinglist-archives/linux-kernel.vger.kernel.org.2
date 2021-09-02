Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0313FF460
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 21:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347440AbhIBTy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 15:54:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42883 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231670AbhIBTyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 15:54:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630612436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0KZsLb+dQjO46E/gdx6NrK5aykQFxATsK6Vcg3WdPIc=;
        b=MsnYLb3HksFklM5FC+JL1b61yPJFgCRigflukNQDXaVwaYxnYwbQV3BpG1ag/gz5CrPk4o
        ezxIaIcgFqPzj/YkmVZdCGmCd3cF8GmJEzJGYF3NMSvoGPBT7IdgTltI9ZEKXCBZeawkES
        ouf8lD486tsihbArBTep5dq8p4G65l0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-oXm6G2KgO7Gwotg9YPd_Eg-1; Thu, 02 Sep 2021 15:53:55 -0400
X-MC-Unique: oXm6G2KgO7Gwotg9YPd_Eg-1
Received: by mail-qk1-f197.google.com with SMTP id y185-20020a3764c20000b02903d2c78226ceso3422689qkb.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 12:53:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0KZsLb+dQjO46E/gdx6NrK5aykQFxATsK6Vcg3WdPIc=;
        b=OOgYJDuuCc7SuSPCdd5xXdUfNW40oXCf4QsgzLL8YtpsSCALJW0yWUqQAWpUMW+VlS
         hUSCnUYaAOr+lO3ETKrBqSc9MGW9+ODHyXHQDhIwUDvvXBEJ+KoV7aT8GKFuH7stv0OV
         L2pcYxpNiRmUftAPbx7H0KmoMTW6U6FkR59ISuCnQedOG+0ppiChLJLpmfFdyETeJq8S
         j8gQSPqLLj3joiwiZqhXkt9urh/D56Iwd6rC/j+kCVlBJZ7NaDSM6ThJ5MrUZ21llL0f
         DtiDAVTNr6JT3rwDnxd2R8cZrEjtRrftvXdPHR7/sG949Y0GFXxTfqWzN031TO8UFToM
         jaUg==
X-Gm-Message-State: AOAM531Jb1ZiaE5UR6A95UTsWZxK5wFA7ZV5UzRSPbHqR1UXwXaMaJ57
        dpBH/fE/E+L7OYK4CGSRWDoN0xt4hWCRdl9yACKUKGNlpRAxefhAQZ3+IEHXz691W2ndI4FSDyV
        P8T0+Z2ZtJgRBifYwcmOle9IC
X-Received: by 2002:a05:6214:c3:: with SMTP id f3mr35454qvs.1.1630612434425;
        Thu, 02 Sep 2021 12:53:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfe+gUFrTXtomtVX2xlzkNBTFg7I3mOh//TVRKhgiquDY4WnrhWTNbYNyI7qpkd/xsfAo6rw==
X-Received: by 2002:a05:6214:c3:: with SMTP id f3mr35435qvs.1.1630612434225;
        Thu, 02 Sep 2021 12:53:54 -0700 (PDT)
Received: from t490s ([2607:fea8:56a3:500::ad7f])
        by smtp.gmail.com with ESMTPSA id l11sm1625458qtv.88.2021.09.02.12.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 12:53:53 -0700 (PDT)
Date:   Thu, 2 Sep 2021 15:53:51 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] KVM: Drop unused kvm_dirty_gfn_harvested()
Message-ID: <YTErzxipuwv7X0Qk@t490s>
References: <20210901230506.13362-1-peterx@redhat.com>
 <87y28flyxj.fsf@vitty.brq.redhat.com>
 <YTD+eBj+9+mb9LVg@google.com>
 <87r1e7lycp.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r1e7lycp.fsf@vitty.brq.redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 06:46:14PM +0200, Vitaly Kuznetsov wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > On Thu, Sep 02, 2021, Vitaly Kuznetsov wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > Drop the unused function as reported by test bot.
> >> 
> >> Your subject line says "Drop unused kvm_dirty_gfn_harvested()" while in
> >> reallity you drop "kvm_dirty_gfn_invalid()".
> >
> > Heh, Peter already sent v2[*].  Though that's a good reminder that it's helpful
> > to reviewers to respond to your own patch if there's a fatal mistake and you're
> > going to immediately post a new version.  For tiny patches it's not a big deal,
> > but for larger patches it can avoid wasting reviewers' time.
> >
> 
> Indeed. It's also a good reminder for reviewers that inbox is best
> treated like a stack and not like a queue :-)

It should really be a queue, to be fair. :)

I normally glance all the emails before looking into the details.  But that's
not an excuse for sure, I should have NACKed that one.  Sorry about that.

-- 
Peter Xu

