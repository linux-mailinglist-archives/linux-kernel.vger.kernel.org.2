Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394B3310043
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 23:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhBDWl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 17:41:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56945 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230104AbhBDWll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 17:41:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612478411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GBsjjTZzpZzHtjldrpCw+SVyqxdXjpA9LJZmLvdvn/s=;
        b=BfHBTa/+Yy44luLsd5IyqRcCqbhUSVuHNKphaYvaFhcXC4eAQljqN4vs0uZqi8g6ACdFqj
        aSZyPpV6ASC0jO5ITDnPMy1DU0QbhdRvjgIaJjWf4KM2F03kcTZd+PMV0baMRRLByEpDwk
        djmLRPsPgrP72S3Bd922C/r8+aDbBrM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-kDLQjmH3OW2x2r3gx3t9Xw-1; Thu, 04 Feb 2021 17:40:01 -0500
X-MC-Unique: kDLQjmH3OW2x2r3gx3t9Xw-1
Received: by mail-wr1-f71.google.com with SMTP id x12so3750677wrw.21
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 14:40:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GBsjjTZzpZzHtjldrpCw+SVyqxdXjpA9LJZmLvdvn/s=;
        b=X1ovD6pfVgyHuGstoQonaQmuL7SROuhHknzlLbgIIfYi1B2RLkqPweHwdQyJOmb6lK
         JStNWTcatXT8cTYUiI2S2eYHiox0QAjr5tbT5X5jOxKooT0XGZdAiTiwRUI4YCDdP6UW
         60YiCtK8x2G9c/KNYTIuZn9X9lTbG/drSNJnFzE5AXfEaTkIeaHkcGasIyykxebCKR89
         3crsgc830SFZg/1Oa9jtLsBcgzgrPBj8OXZ+t2T3mAx0Kk59kmxf0ZB+4UQysaT4ekaV
         acChDEc+gayGeI2VlxGb4aIQYPBx78CbGMReFrJuZgscM74Jk7PADNj5O2i03A6QMxDZ
         J1yA==
X-Gm-Message-State: AOAM531Rf+FqGzw6LymZjd+gGU61WsHV1w1dtVW+LN3pUGqmh9l019Kb
        +lv78BGbnW1tWZCIiZ/zTgB9tmob3v630cO4NGqIDB/lzucJwlDO6OBgFoXFGzQCkpsNzFNkN6U
        a6tidTk8qkYW0pkfBRjnIOwO3
X-Received: by 2002:a05:6000:12c8:: with SMTP id l8mr1574969wrx.81.1612478399889;
        Thu, 04 Feb 2021 14:39:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxiACX91olwg//Ry6RmfPnaxN+GPPpFshRzxO/ndAyxdguZIlrYaq6Fu7Iphb/KQ4Lb7+60iQ==
X-Received: by 2002:a05:6000:12c8:: with SMTP id l8mr1574948wrx.81.1612478399709;
        Thu, 04 Feb 2021 14:39:59 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id d10sm9665506wrn.88.2021.02.04.14.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 14:39:59 -0800 (PST)
Date:   Thu, 4 Feb 2021 23:39:56 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     virtualization@lists.linux-foundation.org, kbuild-all@lists.01.org,
        Xie Yongji <xieyongji@bytedance.com>, kvm@vger.kernel.org,
        Laurent Vivier <lvivier@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 08/13] vdpa: add return value to get_config/set_config
 callbacks
Message-ID: <20210204223956.3uuo7xskjpii3fvw@steredhat>
References: <20210204172230.85853-9-sgarzare@redhat.com>
 <202102050632.J7DMzsOi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <202102050632.J7DMzsOi-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 06:31:20AM +0800, kernel test robot wrote:
>Hi Stefano,
>
>I love your patch! Yet something to improve:
>
>[auto build test ERROR on vhost/linux-next]
>[also build test ERROR on linus/master v5.11-rc6 next-20210125]
>[If your patch is applied to the wrong git tree, kindly drop us a note.
>And when submitting patch, we suggest to use '--base' as documented in
>https://git-scm.com/docs/git-format-patch]
>
>url:    https://github.com/0day-ci/linux/commits/Stefano-Garzarella/vdpa-add-vdpa-simulator-for-block-device/20210205-020448
>base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
>config: parisc-randconfig-r005-20210204 (attached as .config)
>compiler: hppa-linux-gcc (GCC) 9.3.0
>reproduce (this is a W=1 build):
>        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>        chmod +x ~/bin/make.cross
>        # https://github.com/0day-ci/linux/commit/17cf2b1e6be083a27f43414cc0f2524cf81fff60
>        git remote add linux-review https://github.com/0day-ci/linux
>        git fetch --no-tags linux-review Stefano-Garzarella/vdpa-add-vdpa-simulator-for-block-device/20210205-020448
>        git checkout 17cf2b1e6be083a27f43414cc0f2524cf81fff60
>        # save the attached .config to linux build tree
>        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=parisc
>
>If you fix the issue, kindly add following tag as appropriate
>Reported-by: kernel test robot <lkp@intel.com>
>
>All errors (new ones prefixed by >>):
>
>   drivers/vdpa/mlx5/net/mlx5_vnet.c: In function 'mlx5_vdpa_get_config':
>>> drivers/vdpa/mlx5/net/mlx5_vnet.c:1810:10: error: expected ';' before '}' token
>    1810 |  return 0
>         |          ^
>         |          ;
>    1811 | }
>         | ~


Ooops, I forgot to add mlx5_vnet.c on my .config.

Sorry for that, I'll fix in the next release and I'll build all vDPA 
related stuff.

Stefano

