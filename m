Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A55430495
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 21:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240892AbhJPTUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 15:20:17 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:39833 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232336AbhJPTUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 15:20:15 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id EC7FE5C00B9;
        Sat, 16 Oct 2021 15:18:02 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute1.internal (MEProxy); Sat, 16 Oct 2021 15:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=p+3fJpf6HsLcqnYgYGZWWNKUWfCV
        k/9sOVpR4wT6xDE=; b=iyM6CgwiL8L4K3qxv8twtQsIHtWyStR0Pkaug/vgOMfX
        y/9TPdhVHmNLQkLVVU2L+huLud9vyzygfLAE+a+iZFEiPlHAy1+RJwgSFFQ/6e9p
        //my73qVLbjzG02ciupQ/C4TCuKxIbwHOF5EnyCcHaaYbJt3rJ0eZGr2EbdSyhFP
        //rw8s0InEaiptLEXgp4xLLcQX8gyab9f7eL+DOx1cCHBHuk38QDyaIExROhqI5t
        03ZMiQj3qddFWMH8pNRJ/J+gnKHGL6yZVdZ37zwiDXhKk4eSBRd+O3MJDUh/Kkyk
        QDnC3IDR9NlUZEkwiMuTIoXZUZQlyxVYVNavQ+slEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=p+3fJp
        f6HsLcqnYgYGZWWNKUWfCVk/9sOVpR4wT6xDE=; b=maLpXOgCpJEVD49lPeN4l0
        2ijgKcNsDvU0qQUVRRiMhzGgPS5YfeK1IGBTEoxGjqTsZ32GPcvrIV6HXmQAkrl3
        2E3Tft+VcuY7LEncgbP2zfrL/kOdpTgu/2cncBCbmLB0Nta/SLiR2O9AZ/Tj3MzM
        iLqVgrqASaWpozepL8WqIdtrteL7iBZ/5xMcLMxe+P03oDw4mwITmRbBHU+7TeSb
        Lic3A0Eknm1PbwdVkd5iah8AcUW0CrCUhp2DsF012j0CfVmrUpKlhK875gimmaih
        bO+tARmYC+5vvQFY/ItFQOlzRPvpRWTZgOlU/vyZQ3oFtPPzZ1JVYb1hc4sDFh1w
        ==
X-ME-Sender: <xms:aiVrYcx8SDieOobcdHuRfh5A7jWXQLo8AHPx14TFMnZ5EfdPZFfWyQ>
    <xme:aiVrYQSHAlO8S9BKZqlSSEnPP5IQySYg8dZjEhW8lEpX3TTtfKTzurTrySRF3tYh9
    N9NcP8IdXLE8j5u3lI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdduiedguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepvedvgeevuddvvedvgfelfeegiedvgeehieeutdelvedvieevveeljeef
    vedtleehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdr
    uggvvh
X-ME-Proxy: <xmx:aiVrYeVscYTnUlDeaYZ58VaEEKVp5Swt8VaoYQbWJUqWP1WLHdXpqw>
    <xmx:aiVrYaiHIIpRkzf6OZWJScrDAi9W3SBL4vEhbPN32ObJxGOMHwxfKg>
    <xmx:aiVrYeB23gSWgqfV2mfUwmpFKUL9p2xFL-YHJkac8SwxeMXzBsiXFw>
    <xmx:aiVrYUDa67gFr2F8it_drabCZxTKZnXKxOjLPXbE8Ivv85ayB2UDQQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 681BB2740061; Sat, 16 Oct 2021 15:18:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1345-g8441cd7852-fm-20211006.001-g8441cd78
Mime-Version: 1.0
Message-Id: <33b20615-14bb-49e7-ac2a-4bfdfabeaaa4@www.fastmail.com>
In-Reply-To: <CABb+yY2XxpQa-QqsVnzVsYb+msSiOiELE1R5UFjE02Diwww2Ew@mail.gmail.com>
References: <20210916154911.3168-1-sven@svenpeter.dev>
 <20210916154911.3168-3-sven@svenpeter.dev>
 <CABb+yY2XxpQa-QqsVnzVsYb+msSiOiELE1R5UFjE02Diwww2Ew@mail.gmail.com>
Date:   Sat, 16 Oct 2021 21:17:41 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Jassi Brar" <jassisinghbrar@gmail.com>
Cc:     "Rob Herring" <robh+dt@kernel.org>,
        "Mark Kettenis" <mark.kettenis@xs4all.nl>,
        "Hector Martin" <marcan@marcan.st>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Mohamed Mediouni" <mohamed.mediouni@caramail.com>,
        "Stan Skowronek" <stan@corellium.com>,
        "Devicetree List" <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] mailbox: apple: Add driver for Apple mailboxes
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jassi,

Thanks a lot for the review!

On Sat, Oct 16, 2021, at 21:04, Jassi Brar wrote:
> On Thu, Sep 16, 2021 at 10:49 AM Sven Peter <sven@svenpeter.dev> wrote:
>
> ....
>> +static const struct apple_mbox_hw apple_mbox_asc_hw = {
>> +       .control_full = APPLE_ASC_MBOX_CONTROL_FULL,
>> +       .control_empty = APPLE_ASC_MBOX_CONTROL_EMPTY,
>> +
>> +       .a2i_control = APPLE_ASC_MBOX_A2I_CONTROL,
>> +       .a2i_send0 = APPLE_ASC_MBOX_A2I_SEND0,
>> +       .a2i_send1 = APPLE_ASC_MBOX_A2I_SEND1,
>> +
>> +       .i2a_control = APPLE_ASC_MBOX_I2A_CONTROL,
>> +       .i2a_recv0 = APPLE_ASC_MBOX_I2A_RECV0,
>> +       .i2a_recv1 = APPLE_ASC_MBOX_I2A_RECV1,
>> +
>> +       .has_irq_controls = false,
>> +};
>> +
>> +static const struct apple_mbox_hw apple_mbox_m3_hw = {
>> +       .control_full = APPLE_M3_MBOX_CONTROL_FULL,
>> +       .control_empty = APPLE_M3_MBOX_CONTROL_EMPTY,
>> +
>> +       .a2i_control = APPLE_M3_MBOX_A2I_CONTROL,
>> +       .a2i_send0 = APPLE_M3_MBOX_A2I_SEND0,
>> +       .a2i_send1 = APPLE_M3_MBOX_A2I_SEND1,
>> +
>> +       .i2a_control = APPLE_M3_MBOX_I2A_CONTROL,
>> +       .i2a_recv0 = APPLE_M3_MBOX_I2A_RECV0,
>> +       .i2a_recv1 = APPLE_M3_MBOX_I2A_RECV1,
>> +
>> +       .has_irq_controls = true,
>> +       .irq_enable = APPLE_M3_MBOX_IRQ_ENABLE,
>> +       .irq_ack = APPLE_M3_MBOX_IRQ_ACK,
>> +       .irq_bit_recv_not_empty = APPLE_M3_MBOX_IRQ_I2A_NOT_EMPTY,
>> +       .irq_bit_send_empty = APPLE_M3_MBOX_IRQ_A2I_EMPTY,
>> +};
>> +
>> +static const struct of_device_id apple_mbox_of_match[] = {
>> +       { .compatible = "apple,t8103-asc-mailbox", .data = &apple_mbox_asc_hw },
>> +       { .compatible = "apple,t8103-m3-mailbox", .data = &apple_mbox_m3_hw },
>> +       {}
>> +};
>> +MODULE_DEVICE_TABLE(of, apple_mbox_of_match);
>> +
> Traditionally, these go at the end of file.

Ack.

>
> ....
>> +
>> +static int apple_mbox_hw_send(struct apple_mbox *apple_mbox,
>> +                             struct apple_mbox_msg *msg)
>> +{
>> +       if (!apple_mbox_hw_can_send(apple_mbox))
>> +               return -EBUSY;
>> +
>> +       dev_dbg(apple_mbox->dev, "> TX %016llx %08x\n", msg->msg0, msg->msg1);
>> +
>> +       /*
>> +        * This message may be related to a shared memory buffer and we must
>> +        * ensure all previous writes to normal memory are visible before
>> +        * submitting it.
>> +        */
>> +       dma_wmb();
>> +
> This may cause unnecessary overhead.
> mbox_client.tx_prepare() is where the SHMEM data is copied, which
> should also call dma_wmb() just before return.
> ......
>

Ok, I'll just drop it here then.

>> +
>> +static int apple_mbox_hw_recv(struct apple_mbox *apple_mbox,
>> +                             struct apple_mbox_msg *msg)
>> +{
>> +       if (!apple_mbox_hw_can_recv(apple_mbox))
>> +               return -ENOMSG;
>> +
>> +       msg->msg0 = readq_relaxed(apple_mbox->regs + apple_mbox->hw->i2a_recv0);
>> +       msg->msg1 = FIELD_GET(
>> +               APPLE_MBOX_MSG1_MSG,
>> +               readq_relaxed(apple_mbox->regs + apple_mbox->hw->i2a_recv1));
>> +
>> +       dev_dbg(apple_mbox->dev, "< RX %016llx %08x\n", msg->msg0, msg->msg1);
>> +
>> +       /*
>> +        * This message may be related to a shared memory buffer and we must
>> +        * ensure any following reads from normal memory only happen after
>> +        * having read this message.
>> +        */
>> +       dma_rmb();
>> +
> .... similarly should be done by the client as the first thing in recv callback.

Ok.

>
>
>> +static struct mbox_chan *apple_mbox_of_xlate(struct mbox_controller *mbox,
>> +                                            const struct of_phandle_args *spec)
>> +{
>> +       struct apple_mbox *apple_mbox = dev_get_drvdata(mbox->dev);
>> +
>> +       if (spec->args_count != 0)
>> +               return ERR_PTR(-EINVAL);
>> +       if (apple_mbox->chan.con_priv)
>> +               return ERR_PTR(-EBUSY);
>> +
>> +       apple_mbox->chan.con_priv = apple_mbox;
>> +       return &apple_mbox->chan;
>> +}
>> +
> we could do without of_xlate callback, by assigning  chan.con_priv
> already in the .probe()

Sure, will do that.

>
>
>> diff --git a/include/linux/apple-mailbox.h b/include/linux/apple-mailbox.h
>> +
>> +struct apple_mbox_msg {
>> +       u64 msg0;
>> +       u32 msg1;
>> +};
>> +
> Aren't msg0/1 the Tx and Rx channels? If so you may want to separate
> them out as such. But of course, I don't know the h/w details so I may
> be wrong.

This hardware essentially only has a single channel.
Depending on the firmware running on the other side sometimes msg1 is used
as an endpoint index and sometimes 8bits of msg0 are. This is similar to the
discussion about the raspberry pi mailbox hardware [1].



Thanks,


Sven


[1] https://lore.kernel.org/all/550C7534.8070100@wwwdotorg.org/
