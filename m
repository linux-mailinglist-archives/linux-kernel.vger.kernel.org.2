Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3900C3ADBB9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 22:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhFSUoU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 19 Jun 2021 16:44:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:38733 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229475AbhFSUoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 16:44:19 -0400
IronPort-SDR: mwyvUJc52i8OiMr3a17wV8Bdr622pda2o7NBGS7geGt43k4L1JfWqod4LRbxcn1iWUxKM6AKka
 q/0P374QV/gQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10020"; a="193819921"
X-IronPort-AV: E=Sophos;i="5.83,285,1616482800"; 
   d="scan'208";a="193819921"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2021 13:42:07 -0700
IronPort-SDR: j/t/P9ktNrjAQl346jfP2P0A+bzQRnqBcBTlWv+6ktdjG3FPZqqrQuL5ZyP0UOkOQMViVtZSgM
 6Tc88fGMZTzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,285,1616482800"; 
   d="scan'208";a="489455805"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga002.fm.intel.com with ESMTP; 19 Jun 2021 13:42:07 -0700
Received: from hasmsx603.ger.corp.intel.com (10.184.107.143) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Sat, 19 Jun 2021 13:42:06 -0700
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 HASMSX603.ger.corp.intel.com (10.184.107.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Sat, 19 Jun 2021 23:42:04 +0300
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.2242.008;
 Sat, 19 Jun 2021 23:42:04 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [char-misc-next 2/2] mei: revamp mei extension header structure
 layout.
Thread-Topic: [char-misc-next 2/2] mei: revamp mei extension header structure
 layout.
Thread-Index: AQHXYivAs7Yrh3qA70q22HOx3NZkRasX5taAgAPkyLA=
Date:   Sat, 19 Jun 2021 20:42:04 +0000
Message-ID: <31dd3bfbb3e04c9c9a2ccc701b7e56df@intel.com>
References: <20210615211557.248292-1-tomas.winkler@intel.com>
 <20210615211557.248292-2-tomas.winkler@intel.com>
 <YMs2oemOeLvwwnue@kroah.com>
In-Reply-To: <YMs2oemOeLvwwnue@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Wed, Jun 16, 2021 at 12:15:57AM +0300, Tomas Winkler wrote:
> > The mei extension header was build as array of flexible structures
> > which will not work if actually more headers are added
> 
> Why not?  What is wrong with what you currently have?
Because it is not possible to create array of flexible structures in C as far as I know. 

> And did you forget a '.' here?
Thanks will resend. 

> 
> > Use basic type u8 for the variable sized extension.
> > Define explicitly mei_ext_hdr_vtag structure.
> > Fix also mei_ext_next() function to point correctly to the end of the
> > header.
> >
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > ---
> >  drivers/misc/mei/client.c    | 16 +++++++++-------
> >  drivers/misc/mei/hw.h        | 28 ++++++++++++++++++++--------
> >  drivers/misc/mei/interrupt.c | 23 ++++++++++-------------
> >  3 files changed, 39 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
> > index 18e49479d8b0..96f4e59c32a5 100644
> > --- a/drivers/misc/mei/client.c
> > +++ b/drivers/misc/mei/client.c
> > @@ -1726,12 +1726,15 @@ int mei_cl_read_start(struct mei_cl *cl, size_t
> length, const struct file *fp)
> >  	return rets;
> >  }
> >
> > -static inline u8 mei_ext_hdr_set_vtag(struct mei_ext_hdr *ext, u8
> > vtag)
> > +static inline u8 mei_ext_hdr_set_vtag(void *ext, u8 vtag)
> >  {
> > -	ext->type = MEI_EXT_HDR_VTAG;
> > -	ext->ext_payload[0] = vtag;
> > -	ext->length = mei_data2slots(sizeof(*ext));
> > -	return ext->length;
> > +	struct mei_ext_hdr_vtag *vtag_hdr = ext;
> > +
> > +	vtag_hdr->hdr.type = MEI_EXT_HDR_VTAG;
> > +	vtag_hdr->hdr.length = mei_data2slots(sizeof(*vtag_hdr));
> > +	vtag_hdr->vtag = vtag;
> > +	vtag_hdr->reserved = 0;
> > +	return vtag_hdr->hdr.length;
> >  }
> >
> >  /**
> > @@ -1745,7 +1748,6 @@ static struct mei_msg_hdr
> > *mei_msg_hdr_init(const struct mei_cl_cb *cb)  {
> >  	size_t hdr_len;
> >  	struct mei_ext_meta_hdr *meta;
> > -	struct mei_ext_hdr *ext;
> >  	struct mei_msg_hdr *mei_hdr;
> >  	bool is_ext, is_vtag;
> >
> > @@ -1764,7 +1766,7 @@ static struct mei_msg_hdr
> > *mei_msg_hdr_init(const struct mei_cl_cb *cb)
> >
> >  	hdr_len += sizeof(*meta);
> >  	if (is_vtag)
> > -		hdr_len += sizeof(*ext);
> > +		hdr_len += sizeof(struct mei_ext_hdr_vtag);
> >
> >  setup_hdr:
> >  	mei_hdr = kzalloc(hdr_len, GFP_KERNEL); diff --git
> > a/drivers/misc/mei/hw.h b/drivers/misc/mei/hw.h index
> > b10606550613..dfd60c916da0 100644
> > --- a/drivers/misc/mei/hw.h
> > +++ b/drivers/misc/mei/hw.h
> > @@ -235,9 +235,8 @@ enum mei_ext_hdr_type {  struct mei_ext_hdr {
> >  	u8 type;
> >  	u8 length;
> > -	u8 ext_payload[2];
> > -	u8 hdr[];
> > -};
> > +	u8 data[];
> > +} __packed;
> 
> why packed?
It's an aligned structure but still It's HW interface. 
> 
> >
> >  /**
> >   * struct mei_ext_meta_hdr - extend header meta data @@ -250,8
> > +249,21 @@ struct mei_ext_meta_hdr {
> >  	u8 count;
> >  	u8 size;
> >  	u8 reserved[2];
> > -	struct mei_ext_hdr hdrs[];
> > -};
> > +	u8 hdrs[];
> > +} __packed;
> 
> Why packed?
Same here. 

> 
> > +
> > +/**
> > + * struct mei_ext_hdr_vtag - extend header for vtag
> > + *
> > + * @hdr: standard extend header
> > + * @vtag: virtual tag
> > + * @reserved: reserved
> > + */
> > +struct mei_ext_hdr_vtag {
> > +	struct mei_ext_hdr hdr;
> > +	u8 vtag;
> > +	u8 reserved;
> > +} __packed;
> 
> Why packed?
> 
> These are not being read directly from hardware are they?
They are.

Thanks
Tomas

