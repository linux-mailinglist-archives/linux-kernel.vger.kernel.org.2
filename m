Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7473F2224
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 23:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbhHSVOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 17:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbhHSVOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 17:14:38 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492EFC061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 14:14:01 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id i8so14852481ybt.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 14:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cfFiTtfA1GXNy8kvrXCEuCJ8XL9NifAivDptCETkEFM=;
        b=S7/csSf2HUESOOHxnCs4/0atILjl2hF4O0vkCu0V80013iWM93U7/ZPYmXrmBXWD+p
         cB3xzkNBlGju1OrsJCCbkZcMZtFX4oGQzpYlm3+csByjgSiiedhzFi6lgAptGV+y6uQ0
         ox9ue4sAQE4akXkdev7wR1BePo6TFa3eMRp3MTJugwu18VhQXLjJj2OeYm37aSk0awjI
         ZdlioN2v+ExSlvHR6WlAcE2d0Tw76o7NiUH7CEi837gewfqra6A107X7w9+IoAuFI9Hc
         MS880AOyURr4I2i7GcqBcCFk4tY20wXKXHMJvbCqjm5KjH4qjQekHrSDMNhdwkduEKaR
         Ldpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cfFiTtfA1GXNy8kvrXCEuCJ8XL9NifAivDptCETkEFM=;
        b=rB449dnM33mUvAmphNm6H4xux25zpR/wK7T/gSpXKctcJ+IuGhh/dgKoyH6Ds2ExpU
         Dg8XrAAPXU/IOvCu3ohrnQqN68VJUb8Zma2PFPW+pRPR61UIuIT/884YLDpyrB/L+v47
         1IWuNiUPXKfwsSSpGeB735oqqT33MiMV4MnGAYzyEMh4vSSAa7PMH7g0uZmhjXvbAJcV
         m2Ei/6HKspm9fHWxyNrv9xQYFHgozcpG9NYp2gG/rmn9yDAxKx8Y3Ih0xDAKCK1T/61x
         rXYIoi5sKsmYjyvqlTZDCdjVDJyegZNSdWOx+swVeiXlebWtEYl74YunK7c2QioRaPbM
         +YxA==
X-Gm-Message-State: AOAM533EKH7YCHe6rEWTs4fmlbJDAGSFhOEespVZVK7b+QkPOO1B1pIv
        vgUvFTZAu4kqgIJqbn4gWYU+lMU5Hnkruj/QJEZMSQ==
X-Google-Smtp-Source: ABdhPJx4+QvLjcAfFX6/XTAw/6fS9aUnr1VT0IqCwqoUR3pFdRftDL7dhvIsdy+uQc4+qlCxNLvIJLBYsgpLTRi6GK8=
X-Received: by 2002:a25:c9c6:: with SMTP id z189mr17154556ybf.497.1629407640246;
 Thu, 19 Aug 2021 14:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210814031231.32125-1-mdevaev@gmail.com>
In-Reply-To: <20210814031231.32125-1-mdevaev@gmail.com>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date:   Thu, 19 Aug 2021 23:13:48 +0200
Message-ID: <CANP3RGejWk7Zj2XMGGPgrGMSjqRY+ZaVFha6jG720RCSF9HEkQ@mail.gmail.com>
Subject: Re: [PATCH v2] usb: gadget: f_hid: optional SETUP/SET_REPORT mode
To:     Maxim Devaev <mdevaev@gmail.com>
Cc:     balbi@kernel.org, stern@rowland.harvard.edu,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ruslan.bilovol@gmail.com, mika.westerberg@linux.intel.com,
        jj251510319013@gmail.com, linux-usb@vger.kernel.org,
        Kernel hackers <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm a noob when it comes to usb, so some of my questions may well be stupid...

On Sat, Aug 14, 2021 at 5:13 AM Maxim Devaev <mdevaev@gmail.com> wrote:
>
> f_hid provides the OUT Endpoint as only way for receiving reports
> from the host. SETUP/SET_REPORT method is not supported, and this causes
> a number of compatibility problems with various host drivers, especially
> in the case of keyboard emulation using f_hid.
>
> - Some hosts do not support the OUT Endpoint and ignore it,
>   so it becomes impossible for the gadget to receive a report
>   from the host. In the case of a keyboard, the gadget loses the ability
>   to get the status of the LEDs.

perhaps better to rephrase as 'the host ceases to change the status of
the gadget/keyboard LEDs',
unless this is actually driven by the keyboard as opposed to the other
way round (which is what I'd expect from AT, PS/2 keyboards).

> - Some BIOSes/UEFIs can't work with HID with the OUT Endpoint at all.

HID devices with an OUT Endpoint

>   This may be due to their bugs or incomplete implementation
>   of the HID standard.
>   For example, absolutely all Apple UEFIs can't handle the OUT Endpoint
>   if it goes after IN Endpoint in the descriptor and require the reverse
>   order (OUT, IN) which is a violation of the standard.
>   Other hosts either do not initialize gadgets with a descriptor
>   containing the OUT Endpoint completely (like some HP and DELL BIOSes
>   and embedded firmwares like on KVM switches), or initialize them,
>   but will not poll.

Not clear what 'not poll' means here.  Why would they (the host) need
to poll an OUT endpoint?

Additionally it seems like any keyboard gadget would want to default
to the older more compatible mode?
Or are there compatibility problems with it as well?

> This patch adds option no_out_endpoint=1 to disable the OUT Endpoint
> and allow f_hid to receive reports from the host via SETUP/SET_REPORT.

allows

Is this a kcmdline option? module param? sysfs option?
Can one dynamically change this as one reconfigures the gadget for a new mode?

>
> Previously, there was such a feature in f_hid, but it was replaced
> by the OUT Endpoint [1] in the commit 99c515005857 ("usb: gadget: hidg:
> register OUT INT endpoint for SET_REPORT"). So this patch actually returns
> the removed functionality making it optional. For backward compatibility

while making it optional

> reasons, the OUT Endpoint mode remains the default behaviour.
>
> - The OUT Endpoint mode provides the report queue and reduces USB overhead
>   (eliminating SETUP routine) on transmitting a report from the host.
>
> - If the SETUP/SET_REPORT mode is used, there is no report queue,
>   so the userspace will only read the last report. For classic HID

without 'the'

>   devices like keyboard this is not a problem, since it is intended

keyboards

>   to transmit the status of the LEDs and only the last report
>   is important. This mode provides better compatibility with strange
>   and buggy host drivers.
>
> Both modes passed USBCV tests. Checking with the USB protocol analyzer
> also confirmed that everything is working as it should and the new mode
> ensures operability in all of the described cases.
>
> Signed-off-by: Maxim Devaev <mdevaev@gmail.com>
> Link: https://www.spinics.net/lists/linux-usb/msg65494.html [1]
> ---
>  drivers/usb/gadget/function/f_hid.c | 217 +++++++++++++++++++++++-----
>  drivers/usb/gadget/function/u_hid.h |   1 +
>  2 files changed, 185 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
> index bb476e121eae..e3fb73ed696d 100644
> --- a/drivers/usb/gadget/function/f_hid.c
> +++ b/drivers/usb/gadget/function/f_hid.c
> @@ -45,12 +45,17 @@ struct f_hidg {
>         unsigned short                  report_desc_length;
>         char                            *report_desc;
>         unsigned short                  report_length;
> +       bool                            use_out_ep;

this could use a comment along the lines of /* as opposed to SETUP/SET_REPORT */

>
>         /* recv report */
> -       struct list_head                completed_out_req;
>         spinlock_t                      read_spinlock;
>         wait_queue_head_t               read_queue;
> +       /* recv report - interrupt out only (use_out_ep == 1) */
> +       struct list_head                completed_out_req;
>         unsigned int                    qlen;
> +       /* recv report - setup set_report only (use_out_ep == 0) */
> +       char                            *set_report_buf;
> +       unsigned int                    set_report_length;
>
>         /* send report */
>         spinlock_t                      write_spinlock;
> @@ -79,7 +84,7 @@ static struct usb_interface_descriptor hidg_interface_desc = {
>         .bDescriptorType        = USB_DT_INTERFACE,
>         /* .bInterfaceNumber    = DYNAMIC */
>         .bAlternateSetting      = 0,
> -       .bNumEndpoints          = 2,
> +       /* .bNumEndpoints       = DYNAMIC */

if you look down below, this isn't actually dynamic, should we just
have hidg_interface_desc_{intout,ssreport} structs?

>         .bInterfaceClass        = USB_CLASS_HID,
>         /* .bInterfaceSubClass  = DYNAMIC */
>         /* .bInterfaceProtocol  = DYNAMIC */
> @@ -140,7 +145,7 @@ static struct usb_ss_ep_comp_descriptor hidg_ss_out_comp_desc = {
>         /* .wBytesPerInterval   = DYNAMIC */
>  };
>
> -static struct usb_descriptor_header *hidg_ss_descriptors[] = {
> +static struct usb_descriptor_header *hidg_ss_descriptors_intout[] = {
>         (struct usb_descriptor_header *)&hidg_interface_desc,
>         (struct usb_descriptor_header *)&hidg_desc,
>         (struct usb_descriptor_header *)&hidg_ss_in_ep_desc,
> @@ -150,6 +155,14 @@ static struct usb_descriptor_header *hidg_ss_descriptors[] = {
>         NULL,
>  };
>
> +static struct usb_descriptor_header *hidg_ss_descriptors_ssreport[] = {
> +       (struct usb_descriptor_header *)&hidg_interface_desc,
> +       (struct usb_descriptor_header *)&hidg_desc,
> +       (struct usb_descriptor_header *)&hidg_ss_in_ep_desc,
> +       (struct usb_descriptor_header *)&hidg_ss_in_comp_desc,
> +       NULL,
> +};
> +
>  /* High-Speed Support */
>
>  static struct usb_endpoint_descriptor hidg_hs_in_ep_desc = {
> @@ -176,7 +189,7 @@ static struct usb_endpoint_descriptor hidg_hs_out_ep_desc = {
>                                       */
>  };
>
> -static struct usb_descriptor_header *hidg_hs_descriptors[] = {
> +static struct usb_descriptor_header *hidg_hs_descriptors_intout[] = {
>         (struct usb_descriptor_header *)&hidg_interface_desc,
>         (struct usb_descriptor_header *)&hidg_desc,
>         (struct usb_descriptor_header *)&hidg_hs_in_ep_desc,
> @@ -184,6 +197,13 @@ static struct usb_descriptor_header *hidg_hs_descriptors[] = {
>         NULL,
>  };
>
> +static struct usb_descriptor_header *hidg_hs_descriptors_ssreport[] = {
> +       (struct usb_descriptor_header *)&hidg_interface_desc,
> +       (struct usb_descriptor_header *)&hidg_desc,
> +       (struct usb_descriptor_header *)&hidg_hs_in_ep_desc,
> +       NULL,
> +};
> +
>  /* Full-Speed Support */
>
>  static struct usb_endpoint_descriptor hidg_fs_in_ep_desc = {
> @@ -210,7 +230,7 @@ static struct usb_endpoint_descriptor hidg_fs_out_ep_desc = {
>                                        */
>  };
>
> -static struct usb_descriptor_header *hidg_fs_descriptors[] = {
> +static struct usb_descriptor_header *hidg_fs_descriptors_intout[] = {
>         (struct usb_descriptor_header *)&hidg_interface_desc,
>         (struct usb_descriptor_header *)&hidg_desc,
>         (struct usb_descriptor_header *)&hidg_fs_in_ep_desc,
> @@ -218,6 +238,13 @@ static struct usb_descriptor_header *hidg_fs_descriptors[] = {
>         NULL,
>  };
>
> +static struct usb_descriptor_header *hidg_fs_descriptors_ssreport[] = {
> +       (struct usb_descriptor_header *)&hidg_interface_desc,
> +       (struct usb_descriptor_header *)&hidg_desc,
> +       (struct usb_descriptor_header *)&hidg_fs_in_ep_desc,
> +       NULL,
> +};
> +
>  /*-------------------------------------------------------------------------*/
>  /*                                 Strings                                 */
>
> @@ -241,9 +268,11 @@ static struct usb_gadget_strings *ct_func_strings[] = {
>  /*-------------------------------------------------------------------------*/
>  /*                              Char Device                                */
>
> -static ssize_t f_hidg_read(struct file *file, char __user *buffer,
> -                       size_t count, loff_t *ptr)
> +static ssize_t f_hidg_intout_read(struct file *file, char __user *buffer,
> +                                 size_t count, loff_t *ptr)
>  {
> +       /* used only if the OUT endpoint is configured */
> +

comment probably belongs above the function instead of inside it

>         struct f_hidg *hidg = file->private_data;
>         struct f_hidg_req_list *list;
>         struct usb_request *req;
> @@ -255,15 +284,15 @@ static ssize_t f_hidg_read(struct file *file, char __user *buffer,
>
>         spin_lock_irqsave(&hidg->read_spinlock, flags);
>
> -#define READ_COND (!list_empty(&hidg->completed_out_req))
> +#define READ_COND_INTOUT (!list_empty(&hidg->completed_out_req))
>
>         /* wait for at least one buffer to complete */
> -       while (!READ_COND) {
> +       while (!READ_COND_INTOUT) {
>                 spin_unlock_irqrestore(&hidg->read_spinlock, flags);
>                 if (file->f_flags & O_NONBLOCK)
>                         return -EAGAIN;
>
> -               if (wait_event_interruptible(hidg->read_queue, READ_COND))
> +               if (wait_event_interruptible(hidg->read_queue, READ_COND_INTOUT))
>                         return -ERESTARTSYS;
>
>                 spin_lock_irqsave(&hidg->read_spinlock, flags);
> @@ -313,6 +342,62 @@ static ssize_t f_hidg_read(struct file *file, char __user *buffer,
>         return count;
>  }
>
> +#define READ_COND_SSREPORT (hidg->set_report_buf != NULL)
> +
> +static ssize_t f_hidg_ssreport_read(struct file *file, char __user *buffer,
> +                                   size_t count, loff_t *ptr)
> +{
> +       /* used only if the OUT endpoint is NOT configured */
> +
> +       struct f_hidg *hidg = file->private_data;
> +       char *tmp_buf = NULL;
> +       unsigned long flags;
> +
> +       if (!count)
> +               return 0;
> +
> +       spin_lock_irqsave(&hidg->read_spinlock, flags);
> +
> +       while (!READ_COND_SSREPORT) {
> +               spin_unlock_irqrestore(&hidg->read_spinlock, flags);
> +               if (file->f_flags & O_NONBLOCK)
> +                       return -EAGAIN;
> +
> +               if (wait_event_interruptible(hidg->read_queue, READ_COND_SSREPORT))
> +                       return -ERESTARTSYS;
> +
> +               spin_lock_irqsave(&hidg->read_spinlock, flags);
> +       }
> +
> +       count = min_t(unsigned int, count, hidg->set_report_length);
> +       tmp_buf = hidg->set_report_buf;
> +       hidg->set_report_buf = NULL;
> +
> +       spin_unlock_irqrestore(&hidg->read_spinlock, flags);
> +
> +       if (tmp_buf != NULL) {
> +               count -= copy_to_user(buffer, tmp_buf, count);
> +               kfree(tmp_buf);
> +       } else {
> +               count = -ENOMEM;
> +       }
> +
> +       wake_up(&hidg->read_queue);
> +
> +       return count;
> +}
> +
> +static ssize_t f_hidg_read(struct file *file, char __user *buffer,
> +                          size_t count, loff_t *ptr)
> +{
> +       struct f_hidg *hidg = file->private_data;
> +
> +       if (hidg->use_out_ep)
> +               return f_hidg_intout_read(file, buffer, count, ptr);
> +       else
> +               return f_hidg_ssreport_read(file, buffer, count, ptr);
> +}
> +
>  static void f_hidg_req_complete(struct usb_ep *ep, struct usb_request *req)
>  {
>         struct f_hidg *hidg = (struct f_hidg *)ep->driver_data;
> @@ -433,14 +518,20 @@ static __poll_t f_hidg_poll(struct file *file, poll_table *wait)
>         if (WRITE_COND)
>                 ret |= EPOLLOUT | EPOLLWRNORM;
>
> -       if (READ_COND)
> -               ret |= EPOLLIN | EPOLLRDNORM;
> +       if (hidg->use_out_ep) {
> +               if (READ_COND_INTOUT)
> +                       ret |= EPOLLIN | EPOLLRDNORM;
> +       } else {
> +               if (READ_COND_SSREPORT)
> +                       ret |= EPOLLIN | EPOLLRDNORM;
> +       }
>
>         return ret;
>  }
>
>  #undef WRITE_COND
> -#undef READ_COND
> +#undef READ_COND_SSREPORT
> +#undef READ_COND_INTOUT
>
>  static int f_hidg_release(struct inode *inode, struct file *fd)
>  {
> @@ -467,8 +558,10 @@ static inline struct usb_request *hidg_alloc_ep_req(struct usb_ep *ep,
>         return alloc_ep_req(ep, length);
>  }
>
> -static void hidg_set_report_complete(struct usb_ep *ep, struct usb_request *req)
> +static void hidg_intout_complete(struct usb_ep *ep, struct usb_request *req)
>  {
> +       /* used only if the OUT endpoint is configured */
> +

ditto

>         struct f_hidg *hidg = (struct f_hidg *) req->context;
>         struct usb_composite_dev *cdev = hidg->func.config->cdev;
>         struct f_hidg_req_list *req_list;
> @@ -502,6 +595,39 @@ static void hidg_set_report_complete(struct usb_ep *ep, struct usb_request *req)
>         }
>  }
>
> +static void hidg_ssreport_complete(struct usb_ep *ep, struct usb_request *req)
> +{
> +       /* used only if the OUT endpoint is NOT configured */
> +

ditto

> +       struct f_hidg *hidg = (struct f_hidg *)req->context;
> +       struct usb_composite_dev *cdev = hidg->func.config->cdev;
> +       char *new_buf = NULL;
> +       unsigned long flags;
> +
> +       if (req->status != 0 || req->buf == NULL || req->actual == 0) {
> +               ERROR(cdev,
> +                     "%s FAILED: status=%d, buf=%p, actual=%d\n",
> +                     __func__, req->status, req->buf, req->actual);
> +               return;
> +       }
> +
> +       spin_lock_irqsave(&hidg->read_spinlock, flags);
> +
> +       new_buf = krealloc(hidg->set_report_buf, req->actual, GFP_ATOMIC);
> +       if (new_buf == NULL) {
> +               spin_unlock_irqrestore(&hidg->read_spinlock, flags);
> +               return;
> +       }
> +       hidg->set_report_buf = new_buf;
> +
> +       hidg->set_report_length = req->actual;
> +       memcpy(hidg->set_report_buf, req->buf, req->actual);
> +
> +       spin_unlock_irqrestore(&hidg->read_spinlock, flags);
> +
> +       wake_up(&hidg->read_queue);
> +}
> +
>  static int hidg_setup(struct usb_function *f,
>                 const struct usb_ctrlrequest *ctrl)
>  {
> @@ -549,7 +675,11 @@ static int hidg_setup(struct usb_function *f,
>         case ((USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE) << 8
>                   | HID_REQ_SET_REPORT):
>                 VDBG(cdev, "set_report | wLength=%d\n", ctrl->wLength);
> -               goto stall;
> +               if (hidg->use_out_ep)
> +                       goto stall;
> +               req->complete = hidg_ssreport_complete;
> +               req->context  = hidg;
> +               goto respond;
>                 break;
>
>         case ((USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE) << 8
> @@ -637,15 +767,18 @@ static void hidg_disable(struct usb_function *f)
>         unsigned long flags;
>
>         usb_ep_disable(hidg->in_ep);
> -       usb_ep_disable(hidg->out_ep);
>
> -       spin_lock_irqsave(&hidg->read_spinlock, flags);
> -       list_for_each_entry_safe(list, next, &hidg->completed_out_req, list) {
> -               free_ep_req(hidg->out_ep, list->req);
> -               list_del(&list->list);
> -               kfree(list);
> +       if (hidg->out_ep) {
> +               usb_ep_disable(hidg->out_ep);
> +
> +               spin_lock_irqsave(&hidg->read_spinlock, flags);
> +               list_for_each_entry_safe(list, next, &hidg->completed_out_req, list) {
> +                       free_ep_req(hidg->out_ep, list->req);
> +                       list_del(&list->list);
> +                       kfree(list);
> +               }
> +               spin_unlock_irqrestore(&hidg->read_spinlock, flags);
>         }
> -       spin_unlock_irqrestore(&hidg->read_spinlock, flags);
>
>         spin_lock_irqsave(&hidg->write_spinlock, flags);
>         if (!hidg->write_pending) {
> @@ -691,8 +824,7 @@ static int hidg_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
>                 }
>         }
>
> -
> -       if (hidg->out_ep != NULL) {
> +       if (hidg->use_out_ep && hidg->out_ep != NULL) {
>                 /* restart endpoint */
>                 usb_ep_disable(hidg->out_ep);
>
> @@ -717,7 +849,7 @@ static int hidg_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
>                                         hidg_alloc_ep_req(hidg->out_ep,
>                                                           hidg->report_length);
>                         if (req) {
> -                               req->complete = hidg_set_report_complete;
> +                               req->complete = hidg_intout_complete;
>                                 req->context  = hidg;
>                                 status = usb_ep_queue(hidg->out_ep, req,
>                                                       GFP_ATOMIC);
> @@ -743,7 +875,8 @@ static int hidg_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
>         }
>         return 0;
>  disable_out_ep:
> -       usb_ep_disable(hidg->out_ep);
> +       if (hidg->out_ep)
> +               usb_ep_disable(hidg->out_ep);
>  free_req_in:
>         if (req_in)
>                 free_ep_req(hidg->in_ep, req_in);
> @@ -795,14 +928,21 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
>                 goto fail;
>         hidg->in_ep = ep;
>
> -       ep = usb_ep_autoconfig(c->cdev->gadget, &hidg_fs_out_ep_desc);
> -       if (!ep)
> -               goto fail;
> -       hidg->out_ep = ep;
> +       hidg->out_ep = NULL;
> +       if (hidg->use_out_ep) {
> +               ep = usb_ep_autoconfig(c->cdev->gadget, &hidg_fs_out_ep_desc);
> +               if (!ep)
> +                       goto fail;
> +               hidg->out_ep = ep;
> +       }
> +
> +       /* used only if use_out_ep == 1 */
> +       hidg->set_report_buf = NULL;
>
>         /* set descriptor dynamic values */
>         hidg_interface_desc.bInterfaceSubClass = hidg->bInterfaceSubClass;
>         hidg_interface_desc.bInterfaceProtocol = hidg->bInterfaceProtocol;
> +       hidg_interface_desc.bNumEndpoints = hidg->use_out_ep ? 2 : 1;
>         hidg->protocol = HID_REPORT_PROTOCOL;
>         hidg->idle = 1;
>         hidg_ss_in_ep_desc.wMaxPacketSize = cpu_to_le16(hidg->report_length);
> @@ -833,12 +973,19 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
>         hidg_ss_out_ep_desc.bEndpointAddress =
>                 hidg_fs_out_ep_desc.bEndpointAddress;
>
> -       status = usb_assign_descriptors(f, hidg_fs_descriptors,
> -                       hidg_hs_descriptors, hidg_ss_descriptors,
> -                       hidg_ss_descriptors);
> +#define CHOOSE_DESC(prefix)    \
> +       (hidg->use_out_ep ? prefix##_intout : prefix##_ssreport)
> +
> +       status = usb_assign_descriptors(f,
> +               CHOOSE_DESC(hidg_fs_descriptors),
> +               CHOOSE_DESC(hidg_hs_descriptors),
> +               CHOOSE_DESC(hidg_ss_descriptors),
> +               CHOOSE_DESC(hidg_ss_descriptors));

may be better to just use an if (hidg->use_out_ep) status =
usb_assign_descriptors(...) else status = usb_assign_descriptors(...)

(or just status = hidg->use_out_ep ? usb_assign_descriptors(...) :
usb_assign_descriptors(...)

it's not really any longer (when you count up the extra lines adding
and undefing the macro) and eliminates a macro making things easier to
grep for...

>         if (status)
>                 goto fail;
>
> +#undef CHOOSE_DESC
> +
>         spin_lock_init(&hidg->write_spinlock);
>         hidg->write_pending = 1;
>         hidg->req = NULL;
> @@ -950,6 +1097,7 @@ CONFIGFS_ATTR(f_hid_opts_, name)
>
>  F_HID_OPT(subclass, 8, 255);
>  F_HID_OPT(protocol, 8, 255);
> +F_HID_OPT(no_out_endpoint, 8, 1);
>  F_HID_OPT(report_length, 16, 65535);
>
>  static ssize_t f_hid_opts_report_desc_show(struct config_item *item, char *page)
> @@ -1009,6 +1157,7 @@ CONFIGFS_ATTR_RO(f_hid_opts_, dev);
>  static struct configfs_attribute *hid_attrs[] = {
>         &f_hid_opts_attr_subclass,
>         &f_hid_opts_attr_protocol,
> +       &f_hid_opts_attr_no_out_endpoint,
>         &f_hid_opts_attr_report_length,
>         &f_hid_opts_attr_report_desc,
>         &f_hid_opts_attr_dev,
> @@ -1093,6 +1242,7 @@ static void hidg_free(struct usb_function *f)
>         hidg = func_to_hidg(f);
>         opts = container_of(f->fi, struct f_hid_opts, func_inst);
>         kfree(hidg->report_desc);
> +       kfree(hidg->set_report_buf);
>         kfree(hidg);
>         mutex_lock(&opts->lock);
>         --opts->refcnt;
> @@ -1139,6 +1289,7 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
>                         return ERR_PTR(-ENOMEM);
>                 }
>         }
> +       hidg->use_out_ep = !opts->no_out_endpoint;

maybe it would be better to use consistent naming...

hidg->no_out_endpoint = opts->no_out_endpoint

or call the option 'use_ssreport' instead of 'no_out_endpoint'
(negatives are harder to think about)

>
>         mutex_unlock(&opts->lock);
>
> diff --git a/drivers/usb/gadget/function/u_hid.h b/drivers/usb/gadget/function/u_hid.h
> index 98d6af558c03..84bb70292855 100644
> --- a/drivers/usb/gadget/function/u_hid.h
> +++ b/drivers/usb/gadget/function/u_hid.h
> @@ -20,6 +20,7 @@ struct f_hid_opts {
>         int                             minor;
>         unsigned char                   subclass;
>         unsigned char                   protocol;
> +       unsigned char                   no_out_endpoint;
>         unsigned short                  report_length;
>         unsigned short                  report_desc_length;
>         unsigned char                   *report_desc;
> --
> 2.32.0
>

Anyway, nothing in here is particularly important, just loose thoughts.
In general this seems pretty nice.

- Maciej
