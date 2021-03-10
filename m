Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568EB334C8B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 00:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbhCJXaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 18:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbhCJXaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 18:30:16 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48C3C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 15:30:15 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id h13so34014eds.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 15:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vuj/D7o1+/AE9t3wM/vQsuPf0MOJqhA/d5cfPutvQfU=;
        b=o2uQ9nbLBO9R5FOm8KE2FiXDRix0GjxEoucgtHfPLR/wQNZblGYKZeUbZaB3a3gVls
         j5myReVOVSv8e+2as+yWYoc126H5rXjnDz1S/XKEZZqyjP5CjOuJtJdCXwtvh1gGajGB
         AttnNRUhzEiJr3aYXULMyxlHaZvK4tQR2BqqciENC5bZuYnHlM/sDf07rKUZp/9ev5Cl
         YaTNrQmG9WizlGQCUI2TAeuVaoqvCRRHdWDslVQgyQLqCWkKN4ZG/iNSyYEhHzvH3WFj
         K4JoRLLeA8DgfDKV+deTn3ktf5nSBZdM2H3ftPJJGmo54eTR0tvDEMLQuNJeSgoQMGGN
         ngGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vuj/D7o1+/AE9t3wM/vQsuPf0MOJqhA/d5cfPutvQfU=;
        b=SBb4Pae2m4j0+VQ7Q3Ewf6SvUnEYUpbe7ZSRFPP677ZppOrc4kMFqUaZJwa3r7jn7R
         snNqevxAlk5QpMHe/sbOE1deF1uuXs/Mjd+zquJ8eyxcKDyngSF6YgY9zq0MBNVKh6XW
         3t/QKl8NgQS7LXXBGyz7xCbbSpXCaA7CJQ41C2fnjMttPI/0dqlCQxImYb+HWIE2G7Xe
         6DpJQGZRsWiThx9pr8wPtRCKrG4tCMxb8TFMX8Zj3/sdZVly8MTfj2QTKhbvnp1RZK3y
         J/1BcGh32Nj2Mu+Ts5J+xkMayzhv0c33KtE7swAclsW1JrSkjvETcoXIWbBcI8d77weu
         2Njg==
X-Gm-Message-State: AOAM5333lvrdmLRNk7967JEuScSSh3xmujrrsYqNZpUxxhYmKi0CsVYN
        8Ni1Qk2q5lPw8wIi9IeX8CIuovzOoa6iF9p7dDviKok68sE=
X-Google-Smtp-Source: ABdhPJyAUtjsQZeO+IyfOJ0D71CMa4kn2W9c7sy/JaW+YXPD6tUcwvd9d32TJu/3+N1X9rS+ufsB+LKVJeI/Uw+LbQg=
X-Received: by 2002:aa7:c3cd:: with SMTP id l13mr5720329edr.52.1615419014504;
 Wed, 10 Mar 2021 15:30:14 -0800 (PST)
MIME-Version: 1.0
References: <161534060720.528671.2341213328968989192.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210310065425.GA1794@lst.de>
In-Reply-To: <20210310065425.GA1794@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 10 Mar 2021 15:30:02 -0800
Message-ID: <CAPcyv4i4SUEd_zg7HyuqpE3_KUQU=4Pci40CKX7aM6NNsy9wew@mail.gmail.com>
Subject: Re: [PATCH v2] libnvdimm: Notify disk drivers to revalidate region read-only
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Ming Lei <ming.lei@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        kernel test robot <lkp@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 9, 2021 at 10:54 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Looks good to me:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> Question on the pre-existing code: given that nvdimm_check_and_set_ro is
> the only caller of set_disk_ro for nvdimm devices, we'll also get
> the message when initially setting up any read-only disk.  Is that
> intentional?

Yeah, that's intentional. There's no other notification that userspace
would be looking for by default besides the kernel log, and the block
device name is more meaningful than the region name, or the nvdimm
device status for that matter.
