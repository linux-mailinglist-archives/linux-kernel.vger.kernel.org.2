Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21331395AA6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 14:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhEaMfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 08:35:40 -0400
Received: from mga18.intel.com ([134.134.136.126]:42225 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231377AbhEaMfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 08:35:38 -0400
IronPort-SDR: m5MIFJt4rpb+cdYmkkYmRVvhAPXZIpatJD4bDdpQhI/P+zuzIKrA699Q8pfEO8RgiGHdbugXgo
 e3qISxMpBm0w==
X-IronPort-AV: E=McAfee;i="6200,9189,10000"; a="190711866"
X-IronPort-AV: E=Sophos;i="5.83,237,1616482800"; 
   d="scan'208";a="190711866"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 05:33:55 -0700
IronPort-SDR: CjjbPz5fMAuEqn0ZIyienNP5xgz4ay/aGLJGaCHoHm1ho8HO0ZKuk14puks00OFegbtWm8iAmh
 sajrjvAwN1Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,237,1616482800"; 
   d="scan'208";a="549400165"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 31 May 2021 05:33:52 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 31 May 2021 15:33:52 +0300
Date:   Mon, 31 May 2021 15:33:52 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Jun Li <jun.li@nxp.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] usb: typec: mux: Remove requirement for the
 "orientation-switch" device property
Message-ID: <YLTXsKoe9JTKp43f@kuha.fi.intel.com>
References: <20210526153548.61276-1-heikki.krogerus@linux.intel.com>
 <20210526153548.61276-3-heikki.krogerus@linux.intel.com>
 <VI1PR04MB59350F5BC9129F9E0B21773889229@VI1PR04MB5935.eurprd04.prod.outlook.com>
 <YLSPLxfyavO+AkLY@kuha.fi.intel.com>
 <YLSW0IoHdnzRSzUW@kuha.fi.intel.com>
 <YLSdptmScGo5TJ1D@kuha.fi.intel.com>
 <VI1PR04MB5935F74E297A467D846AADEC893F9@VI1PR04MB5935.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB5935F74E297A467D846AADEC893F9@VI1PR04MB5935.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Oh no. This patch just landed into Greg's usb-next. I'll prepare the
> > > revert. I'm sorry about this.
> > 
> > Actually, if we always need that extra (boolean) device property to identify
> > the device class when OF graph is used, 
> 
> Looks like yes, as we need a way to know if the current fwnode
> is for the target device we are looking for, to return probe
> defer correctly.
> 
> > shouldn't we just do that always
> > in fwnode_graph_devcon_match()?
> 
> This depends on if we want to limit this to be a boolean property
> (to mark this is the target fwnode), or make it to be more generic
> so user can define it in its ->match().
> 
> Now there are only 2 users of it, role switch and typec mux, both work
> as a boolean property for con_id.


OK. Let's leave to the users for now.

thanks,

-- 
heikki
