Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F73418477
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 22:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhIYUkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 16:40:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:36670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229854AbhIYUkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 16:40:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E03560F4B;
        Sat, 25 Sep 2021 20:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632602340;
        bh=ldPHFYhy+RgAg2IGaXUZcTLr+nQ9ccV2OZg06CSTSmE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OjyMVsIk3A/oEI9NPBBezI+qeW1CYvmErbWkLb/+Wq6CnZVuxhJQBoxIbx5k0TgRT
         JQQhComOB1XCkrGV1sfu/nfjaZhOSJkRfrK0kDsfFbrJ2cezz88aRIkxmEJU6OkwLI
         qLsyU8PrtSYwyRt7eOK7aCQAbdRdMLTLomk3NpR3ZAP9ubjuh6Y/l17gvzdbE0IPk5
         2h72jPoHEYlxUnaYjN6gvwDB6Kha4aJWHLBhJl89ZJy3z68G2twuf/WEpNSEZDj/9Y
         NQsFDp5VC2K9cxAiF7PrF6RYQbxL4Sgdbd3hjHbVmowm7pEUA10C9d0A3xn6kuO6Mm
         /e7/IIhTS0Ihg==
Date:   Sat, 25 Sep 2021 13:38:57 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Aditya Garg <gargaditya08@live.com>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "james.smart@broadcom.com" <james.smart@broadcom.com>,
        "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trivial@kernel.org" <trivial@kernel.org>
Subject: Re: [PATCH] Urgent bug fix causing Apple SSDs to not work.
Message-ID: <20210925203857.GC116968@dhcp-10-100-145-180.wdc.com>
References: <PNZPR01MB4415600ACD3C8D9944F15058B8A59@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
 <CAHk-=wgML11x9afCvmg9yhVm9wi5mvnjBvmX+i7OfMA0Vd4FWA@mail.gmail.com>
 <20210925195425.GB116968@dhcp-10-100-145-180.wdc.com>
 <4849f3d3-4abd-49b7-b053-d7965daa7138@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4849f3d3-4abd-49b7-b053-d7965daa7138@www.fastmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2021 at 10:08:53PM +0200, Sven Peter wrote:
> I actually ran into a similar issue while adding support for the NVMe
> controller found on the M1 and assumed it was only present there.
> 
> Some background why this happens: ANS2 is a co-processor that emulates
> an NVMe MMIO interface and uses the tag as an index to an internal data
> structure. 

Thanks for confirming the behavior. The patch should restore the
command_id values to when everything was working. I'll just need to
update the quirk description to better align with the actual limitation
if the patch is successful. 

> On the M1 we can directly talk to ANS2 and while we can submit
> commands with a higher index it'll just ignore the upper bits and only
> return the lowest eight IIRC in the completion queue.
> I guess whatever software is running on the T2 actually has an assert to
> ensure that the tag is within the limits before forwarding the command
> to ANS2.

Is the PCI Device ID for the M1 the same as reported for the T2? Either
0x2005 or 0x2003 should make this quirk apply.

Side note, I mistakenly added an entry for device ID 0x2006, but that
was from me misreading the report.

> Best,
> 
> Sven
> 
> 
> On Sat, Sep 25, 2021, at 21:54, Keith Busch wrote:
> > On Sat, Sep 25, 2021 at 11:47:08AM -0700, Linus Torvalds wrote:
> >> On Fri, Sep 24, 2021 at 9:02 PM Aditya Garg <gargaditya08@live.com> wrote:
> >> >
> >> > From: Aditya Garg <gargaditya08@live.com>
> >> > Date: Fri, 24 Sep 2021 15:36:45 +0530
> >> > Subject: [PATCH] Revert nvme to 5.14.5 to fix incompatibility arised in Apple SSDs.
> >> > Fixes: e7006de6c238 (nvme: code command_id with a genctr for use-after-free validation)
> >> 
> >> I think we need to hear more about the problem than just revert a
> >> commit like this randomly. That commit has already been picked up for
> >> -stable,
> >> 
> >> What are the exact symptoms, and which Apple SSD is this?
> >> 
> >> I do find this:
> >> 
> >>   https://lore.kernel.org/all/cjJiSFV77WM51ciS8EuBcdeBcv9T83PUB-Kw3yi8PuC_LwrrUUnQ3w5RC1PbKvSYE72KryXp3wOJhv4Ov_WWIe2gKWOOo5uwuUjbbFA8HDM=@protonmail.com/
> >> 
> >> which instead of a revert has an actual patch. Can you try that one?
> >> 
> >> Keith Busch replied to that one, saying that the Apple SSD might not
> >> be spec compliant, but hey, what else is new? If we start demanding
> >> that hardware comply with specs, we'd have to scrap the whole notion
> >> of working in the real world. Plus it would be very hypocritical of
> >> us, since we ignore all specs when we deem them too limiting (whether
> >> they be language specs, POSIX OS specs, or whatever).
> >
> > Right, we have a lot of quirks for the apple controllers, what's one
> > more? :)
> >
> > Could the following patch be tried? I'm basing this off the 'lspci' from
> > Orlando, but I'm assuming the previous model has the same limitation,
> > too.
> >
> > ---
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 7efb31b87f37..f0787233557f 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -979,6 +979,7 @@ EXPORT_SYMBOL_GPL(nvme_cleanup_cmd);
> >  blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
> >  {
> >  	struct nvme_command *cmd = nvme_req(req)->cmd;
> > +	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
> >  	blk_status_t ret = BLK_STS_OK;
> > 
> >  	if (!(req->rq_flags & RQF_DONTPREP)) {
> > @@ -1027,7 +1028,8 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, 
> > struct request *req)
> >  		return BLK_STS_IOERR;
> >  	}
> > 
> > -	nvme_req(req)->genctr++;
> > +	if (!(ctrl->quirks & NVME_QUIRK_SKIP_CID_GEN))
> > +		nvme_req(req)->genctr++;
> >  	cmd->common.command_id = nvme_cid(req);
> >  	trace_nvme_setup_cmd(req, cmd);
> >  	return ret;
> > diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> > index 9871c0c9374c..b49761d30df7 100644
> > --- a/drivers/nvme/host/nvme.h
> > +++ b/drivers/nvme/host/nvme.h
> > @@ -86,6 +86,12 @@ enum nvme_quirks {
> >  	 */
> >  	NVME_QUIRK_NO_DEEPEST_PS		= (1 << 5),
> > 
> > +	/*
> > +	 * The controller requires the command_id value be be limited to the
> > +	 * queue depth.
> > +	 */
> > +	NVME_QUIRK_SKIP_CID_GEN			= (1 << 6),
> > +
> >  	/*
> >  	 * Set MEDIUM priority on SQ creation
> >  	 */
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index b82492cd7503..d9f22ed68185 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -3369,7 +3369,10 @@ static const struct pci_device_id nvme_id_table[] = {
> >  	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2005),
> >  		.driver_data = NVME_QUIRK_SINGLE_VECTOR |
> >  				NVME_QUIRK_128_BYTES_SQES |
> > -				NVME_QUIRK_SHARED_TAGS },
> > +				NVME_QUIRK_SHARED_TAGS ,
> > +				NVME_QUIRK_SKIP_CID_GEN },
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2006),
> > +		.driver_data = NVME_QUIRK_SKIP_CID_GEN },
> > 
> >  	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
> >  	{ 0, }
> > --
> 
> -- 
> Sven Peter
