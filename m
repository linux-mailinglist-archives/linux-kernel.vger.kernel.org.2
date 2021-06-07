Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA2139D56A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 08:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhFGGxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 02:53:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50269 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229436AbhFGGxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 02:53:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623048714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4o9AFYShIiOudrYVWqeWOS4+by7917Hd7h/BZiXVljU=;
        b=EmzsBICWgjwWohn7DErN7FOn0czdUqs7DbzNews2wSA1iL4EiwdBFxr8xnjZKKq93EI7XO
        /sSZvg9zr3onC2XGHigaH8OMIR2xxKIHZzkCLc+BAag00NzAsl29XuWGHGU42yT4eYusjS
        4+QF1+5wurNyy0s1zXACRX39YC0gQKo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-e5aZtrgoPVC9-RLc8tXXVg-1; Mon, 07 Jun 2021 02:51:47 -0400
X-MC-Unique: e5aZtrgoPVC9-RLc8tXXVg-1
Received: by mail-wr1-f72.google.com with SMTP id z3-20020adfdf830000b02901198337bc39so6856693wrl.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 23:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4o9AFYShIiOudrYVWqeWOS4+by7917Hd7h/BZiXVljU=;
        b=dJo9NlczuKnSpfck56yJDchUE9/9yGTEsQKc5B/xwSLYhYBcC9OBNQ7k/1/hpZu7Tu
         MUHGx8TTvDPwOuyBEep6QEgGokylvI+DDvQJKVpTPwwtCAg7JtR8QFEaEqf242X31bEd
         Zc0UnlDhDyN85LlPvTB3hgjjAFItjwgezzo2k7EmZprHkF1pn/NxOiypM39MZAQ/S9l9
         9f3iAdj4cYnk8nt06fh1vXlqyM3FLRle9UTauu6WpG5BlUG1azSgcdTZdN3P2m4/LSkO
         FHyPkWKNMS9eZ0bb5/b0s1U8//pcepzt++dQlwxfyHpx85sua0bz9rUjB+BDEqkX3+Y+
         jE1Q==
X-Gm-Message-State: AOAM531AieHGLAz0ewmMHvnGJrT82rvp2KN4JTOK3XA3ed+3b3k3dbn4
        o7GNN2FEpJiUwuFvKQN1/PNMFON+fwI6UPYdrqTIAC0Rjk+ciRgu2Y7jIIdU7xUQPs+IWwA2W/J
        i/4UK5Ko++aMkdo2NwjWwTR10
X-Received: by 2002:adf:f5c9:: with SMTP id k9mr14884344wrp.180.1623048706568;
        Sun, 06 Jun 2021 23:51:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjl6kAxqdninZuAYWFjtkVqJV6rZp5he0mQ6HQTxXN95BQKqkqQuB5NoWIDG/dxC45jrIuBw==
X-Received: by 2002:adf:f5c9:: with SMTP id k9mr14884320wrp.180.1623048706334;
        Sun, 06 Jun 2021 23:51:46 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id o6sm16499918wre.73.2021.06.06.23.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jun 2021 23:51:45 -0700 (PDT)
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Robin Murphy <robin.murphy@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jason Wang <jasowang@redhat.com>
References: <20210603201018.GF1002214@nvidia.com>
 <20210603154407.6fe33880.alex.williamson@redhat.com>
 <MWHPR11MB1886469C0136C6523AB158B68C3B9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210604122830.GK1002214@nvidia.com>
 <20210604092620.16aaf5db.alex.williamson@redhat.com>
 <815fd392-0870-f410-cbac-859070df1b83@redhat.com>
 <20210604155016.GR1002214@nvidia.com>
 <30e5c597-b31c-56de-c75e-950c91947d8f@redhat.com>
 <20210604160336.GA414156@nvidia.com>
 <2c62b5c7-582a-c710-0436-4ac5e8fd8b39@redhat.com>
 <20210604172207.GT1002214@nvidia.com>
 <20210604152918.57d0d369.alex.williamson@redhat.com>
 <MWHPR11MB1886E95C6646F7663DBA10DD8C389@MWHPR11MB1886.namprd11.prod.outlook.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9dc6c573-94df-a7c1-b4df-7f60fc3cf336@redhat.com>
Date:   Mon, 7 Jun 2021 08:51:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB1886E95C6646F7663DBA10DD8C389@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/21 05:25, Tian, Kevin wrote:
> Per Intel SDM wbinvd is a privileged instruction. A process on the
> host has no privilege to execute it.

(Half of) the point of the kernel is to do privileged tasks on the 
processes' behalf.  There are good reasons why a process that uses VFIO 
(without KVM) could want to use wbinvd, so VFIO lets them do it with a 
ioctl and adequate checks around the operation.

Paolo

