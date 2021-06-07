Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3DD39E8FB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 23:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhFGVR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 17:17:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55883 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230359AbhFGVRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 17:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623100563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A+QzMHSr7n2QYrg6dy0pAA83S+etUHMxpNVRGxxeZWk=;
        b=TtT1+4fDHCTQO2fXTUjiqC0uq+PqhfRhXquACBHk52BN23aAztfAqTIyQgF8tcJm2qpz2J
        H5WXgUnjJazfJpucIaYWvUbFxFHXBTtUCxODgv+VtMwzW8wnFByzkAUZDOkxil0w4NPdK7
        PLp3PeC68vIPTY414k3pRynAMTFsrHU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-TtkK49JpOEme9ZGDoNXWWQ-1; Mon, 07 Jun 2021 17:16:02 -0400
X-MC-Unique: TtkK49JpOEme9ZGDoNXWWQ-1
Received: by mail-wm1-f71.google.com with SMTP id n2-20020a05600c3b82b02901aeb7a4ac06so341038wms.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 14:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A+QzMHSr7n2QYrg6dy0pAA83S+etUHMxpNVRGxxeZWk=;
        b=TFac1QubEHuJcpSPOW799kDVhYj7Vxwj/btNpZMqzTixbv+IaXy7hqGdIAE+hvPxQo
         e4nI32w7cdbcXs2LuPHW4kVwI/mT9xpkOcOMGKYN9ouzD88nlav3f2yEIj8aj1IE1u1v
         heI3P/9/uxZx+MEsLszcNoSmG9YIZwEo+lK2sP8jQ9K5mB4toDEs/kc8SVKQA5bn+h3t
         9+fG4nSugGPizrH8R59qgXxt25Y2J3EOEgWT4ehW+yp67E2C9RVG9J5418pyqSgCRC1F
         YiWIBDS4NzGSBzhuVdu5a991QlpPZtOyeJRWsUly9s5jpc60uaOzCg6OTgxPxNaecuao
         /6nA==
X-Gm-Message-State: AOAM532FIa9s++2nMsLD7MsIBTyNaO2OYa93+XrvcuoE1wktnbaLLKLr
        GezJUygJEUKo/HSYKnuomfmgrHikS5FegD/rxewJuS3/W2dPjlxHItvBliRK72TLVMXL7MCXkOK
        RLOF7lwWmfEqwHaRWT9Y7qCs=
X-Received: by 2002:a05:600c:4fd0:: with SMTP id o16mr941164wmq.50.1623100561409;
        Mon, 07 Jun 2021 14:16:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3V+zuUDialUWMMqBnkiTOsZ4fl0eGLPMuveDftvGRavXQ3gAgJaZiJrZ5XrNITr1JOQ5oUw==
X-Received: by 2002:a05:600c:4fd0:: with SMTP id o16mr941155wmq.50.1623100561211;
        Mon, 07 Jun 2021 14:16:01 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id n1sm7999008wms.18.2021.06.07.14.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 14:16:00 -0700 (PDT)
Date:   Mon, 7 Jun 2021 22:16:00 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Waiman Long <llong@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeelb@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm/oom_kill: allow oom kill allocating task for
 non-global case
Message-ID: <20210607211600.yki3byc7i73ij7ra@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20210607163103.632681-1-atomlin@redhat.com>
 <c16893a9-35e2-7625-d7f3-83488f874040@redhat.com>
 <CALvZod4eUoquGTQ5AsWgbWTQyqtCNNwb-9+fRw_ZPavH-r9dbA@mail.gmail.com>
 <dc7f54eb-933e-5bbb-7959-815dfbfcc836@redhat.com>
 <YL5tqdw+iWLLavxV@dhcp22.suse.cz>
 <6d23ce58-4c4b-116a-6d74-c2cf4947492b@redhat.com>
 <YL51Tp/3jVHUrpuj@dhcp22.suse.cz>
 <a25c980a-2c26-2df4-9375-3ca91d677099@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a25c980a-2c26-2df4-9375-3ca91d677099@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-06-07 16:42 -0400, Waiman Long wrote:
> Right. I don't know why the current cannot be selected. I think we may need
> to enhance the OOM but no killable process report to list the reason a task
> is skipped other than oom_score_adj.

Actually, this might be a good idea.

-- 
Aaron Tomlin

