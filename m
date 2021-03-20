Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D877343011
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 23:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhCTWhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 18:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbhCTWhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 18:37:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB5EC061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 15:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Fo07rwgSbncNv9g8juqCxf2tFviU98VyJSW5pomvlzw=; b=FLd2MDmDl3qTCl/TN5j9lyUFwu
        budKs1q8Mnpuxs7l4VfdmMd70w0JL+jq3ncRScA0ZD8WO9zLkbX35145VyLyxmfZPPVb2JOWPIB5l
        z547aBNGLIk4sg4MYYG8FfNKIpbxZTfMJiBYErCACWfOZRvmY7X0nUtv44qzVXQoE4Ny0l4mtTPgn
        ZEmnE464VYJyN2VCSU9T9BJdNgQfpwtmTcgPPXA2iuNhjEPB5NntQJv81Wyqe8bIZvwhoL14w+/T9
        jhSYwQc3uKDDWNoKTEAmVBYMFiRDKz7v8lSs3XKwshRNYs8GrlG0hn3dhWLKZ7bImctMQyjPpBU//
        qXi6gc1g==;
Received: from rdunlap (helo=localhost)
        by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
        id 1lNkDc-0024Zw-1x; Sat, 20 Mar 2021 22:37:17 +0000
Date:   Sat, 20 Mar 2021 15:37:16 -0700 (PDT)
From:   Randy Dunlap <rdunlap@bombadil.infradead.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
cc:     james.smart@broadcom.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-fc: Few trivial spelling fixes
In-Reply-To: <20210320203002.13902-1-unixbhaskar@gmail.com>
Message-ID: <33e8935b-83f8-3384-dbdc-717988c59faa@bombadil.infradead.org>
References: <20210320203002.13902-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: Randy Dunlap <rdunlap@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210320_153716_124503_F91FB77D 
X-CRM114-Status: GOOD (  21.97  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: Spam detection software, running on the system "bombadil.infradead.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On Sun, 21 Mar 2021, Bhaskar Chowdhury wrote: > > s/boundarys/boundaries/
    ..... two different places > s/assocated/associated/ > s/compeletion/completion/
    > s/tranferred/transferred/ > s/subsytem/subsystem/ > > Signed-off-by: Bhaskar
    Chowdhury <u [...] 
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 21 Mar 2021, Bhaskar Chowdhury wrote:

>
> s/boundarys/boundaries/ ..... two different places
> s/assocated/associated/
> s/compeletion/completion/
> s/tranferred/transferred/
> s/subsytem/subsystem/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
> include/linux/nvme-fc-driver.h | 12 ++++++------
> 1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/nvme-fc-driver.h b/include/linux/nvme-fc-driver.h
> index 2a38f2b477a5..8624b0c6aace 100644
> --- a/include/linux/nvme-fc-driver.h
> +++ b/include/linux/nvme-fc-driver.h
> @@ -441,7 +441,7 @@ struct nvme_fc_remote_port {
>  * @dma_boundary:  indicates the dma address boundary where dma mappings
>  *       will be split across.
>  *       Value is Mandatory. Typical value is 0xFFFFFFFF to split across
> - *       4Gig address boundarys
> + *       4Gig address boundaries
>  *
>  * @local_priv_sz: The LLDD sets this field to the amount of additional
>  *       memory that it would like fc nvme layer to allocate on the LLDD's
> @@ -608,7 +608,7 @@ enum {
>  *
>  * Structure used between LLDD and nvmet-fc layer to represent the exchange
>  * context for a FC-NVME FCP I/O operation (e.g. a nvme sqe, the sqe-related
> - * memory transfers, and its assocated cqe transfer).
> + * memory transfers, and its associated cqe transfer).
>  *
>  * The structure is allocated by the LLDD whenever a FCP CMD IU is received
>  * from the FC link. The address of the structure is passed to the nvmet-fc
> @@ -631,7 +631,7 @@ enum {
>  *   When the structure is used for an FCP target operation, the nvmet-fc
>  *     layer will fully set the fields in order to specify the scattergather
>  *     list, the transfer length, as well as the done routine to be called
> - *     upon compeletion of the operation.  The nvmet-fc layer will also set a
> + *     upon completion of the operation.  The nvmet-fc layer will also set a
>  *     private pointer for its own use in the done routine.
>  *
>  * Values set by the NVMET-FC layer prior to calling the LLDD fcp_op
> @@ -640,7 +640,7 @@ enum {
>  * @hwqid:    Specifies the hw queue index (0..N-1, where N is the
>  *            max_hw_queues value from the LLD's nvmet_fc_target_template)
>  *            that the operation is to use.
> - * @offset:   Indicates the DATA_OUT/DATA_IN payload offset to be tranferred.
> + * @offset:   Indicates the DATA_OUT/DATA_IN payload offset to be transferred.
>  *            Field is only valid on WRITEDATA, READDATA, or READDATA_RSP ops.
>  * @timeout:  amount of time, in seconds, to wait for a response from the NVME
>  *            host. A value of 0 is an infinite wait.
> @@ -718,7 +718,7 @@ enum {
>  *
>  * Fields with static values for the port. Initialized by the
>  * port_info struct supplied to the registration call.
> - * @port_num:  NVME-FC transport subsytem port number
> + * @port_num:  NVME-FC transport subsystem port number
>  * @node_name: FC WWNN for the port
>  * @port_name: FC WWPN for the port
>  * @private:   pointer to memory allocated alongside the local port
> @@ -919,7 +919,7 @@ struct nvmet_fc_target_port {
>  * @dma_boundary:  indicates the dma address boundary where dma mappings
>  *       will be split across.
>  *       Value is Mandatory. Typical value is 0xFFFFFFFF to split across
> - *       4Gig address boundarys
> + *       4Gig address boundaries
>  *
>  * @target_features: The LLDD sets bits in this field to correspond to
>  *       optional features that are supported by the LLDD.
> --
> 2.26.2
>
>
