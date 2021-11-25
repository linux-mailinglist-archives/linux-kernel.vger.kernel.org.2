Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB8A45DED2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 17:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241230AbhKYQ6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 11:58:10 -0500
Received: from smtprelay0147.hostedemail.com ([216.40.44.147]:45076 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241882AbhKYQ4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 11:56:09 -0500
Received: from omf15.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 64FA789B2E;
        Thu, 25 Nov 2021 16:52:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id B192B2000262;
        Thu, 25 Nov 2021 16:52:53 +0000 (UTC)
Message-ID: <44a56ee66e1d635306f674d5646b19d059c5252b.camel@perches.com>
Subject: Re: drivers/vdpa/vdpa.c:296 vdpa_mgmtdev_fill() warn: should
 '(((1))) << (mdev->id_table[i]->device)' be a 64 bit type?
From:   Joe Perches <joe@perches.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, Parav Pandit <parav@nvidia.com>,
        lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Date:   Thu, 25 Nov 2021 08:52:54 -0800
In-Reply-To: <20211125111511-mutt-send-email-mst@kernel.org>
References: <202111250317.VUsGtdox-lkp@intel.com>
         <20211125111511-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ppop7bugp5ntdcmrw6y4nwfrknpszhxe
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: B192B2000262
X-Spam-Status: No, score=-3.90
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18ll0xI4QYhOr89FoyJDqd785lrXrDxOos=
X-HE-Tag: 1637859173-622950
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-11-25 at 11:15 -0500, Michael S. Tsirkin wrote:
> On Thu, Nov 25, 2021 at 10:03:28AM +0300, Dan Carpenter wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   5d9f4cf36721aba199975a9be7863a3ff5cd4b59
> > commit: 33b347503f014ebf76257327cbc7001c6b721956 vdpa: Define vdpa mgmt device, ops and a netlink interface
> > config: i386-randconfig-m021-20211118 (https://download.01.org/0day-ci/archive/20211125/202111250317.VUsGtdox-lkp@intel.com/config)
> > compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > smatch warnings:
> > drivers/vdpa/vdpa.c:296 vdpa_mgmtdev_fill() warn: should '(((1))) << (mdev->id_table[i]->device)' be a 64 bit type?
> > 
> > vim +296 drivers/vdpa/vdpa.c
> > 
> > 33b347503f014eb Parav Pandit 2021-01-05  280  static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk_buff *msg,
> > 33b347503f014eb Parav Pandit 2021-01-05  281  			     u32 portid, u32 seq, int flags)
> > 33b347503f014eb Parav Pandit 2021-01-05  282  {
> > 33b347503f014eb Parav Pandit 2021-01-05  283  	u64 supported_classes = 0;
> >                                                 ^^^^^^^^^^^^^^^^^^^^^
> > This is a u64
> > 
> > 33b347503f014eb Parav Pandit 2021-01-05  284  	void *hdr;
> > 33b347503f014eb Parav Pandit 2021-01-05  285  	int i = 0;
> > 33b347503f014eb Parav Pandit 2021-01-05  286  	int err;
> > 33b347503f014eb Parav Pandit 2021-01-05  287  
> > 33b347503f014eb Parav Pandit 2021-01-05  288  	hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags, VDPA_CMD_MGMTDEV_NEW);
> > 33b347503f014eb Parav Pandit 2021-01-05  289  	if (!hdr)
> > 33b347503f014eb Parav Pandit 2021-01-05  290  		return -EMSGSIZE;
> > 33b347503f014eb Parav Pandit 2021-01-05  291  	err = vdpa_nl_mgmtdev_handle_fill(msg, mdev);
> > 33b347503f014eb Parav Pandit 2021-01-05  292  	if (err)
> > 33b347503f014eb Parav Pandit 2021-01-05  293  		goto msg_err;
> > 33b347503f014eb Parav Pandit 2021-01-05  294  
> > 33b347503f014eb Parav Pandit 2021-01-05  295  	while (mdev->id_table[i].device) {
> > 33b347503f014eb Parav Pandit 2021-01-05 @296  		supported_classes |= BIT(mdev->id_table[i].device);
> > 
> > Which suggests that this should be BIT_ULL().

True but it seems all of these tables have only 1 or
at most 3 non-null terminated entries.

It looks as if mdev->id_table itself could be NULL though:

drivers/vdpa/virtio_pci/vp_vdpa.c:      .id_table       = NULL, /* only dynamic ids */

which _might_ cause a null dereference.  Dunno if that's possible.


