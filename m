Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9683F4FD9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 19:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbhHWRvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 13:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbhHWRvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 13:51:04 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A21C061757
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:50:21 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id z18so35658203ybg.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 10:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E6CBG18rLLwer67fpLmRifuggE8h6Z/cX/LJkNlPt6c=;
        b=X6f9mU6i6KATzYZehFS4aKSsGd/VvvjqP1tcHMg0ExIzX4/wPvsEFL5ibKIHTwcA2+
         kbv6eyRX38DEkS6J6gorrJ8TqlSuYq1BokiWpVIeufHgr4a2GUgIAI8WnHTiTef6RWeT
         svGSMuDJD69p7sbmDAezGt0wx8lINLffmVKOfIuJriFiUSc/Z1tLwrSvmFkjI92E1GmY
         dpYMVxb/mv4jmgJbjYY48Vi/v9jCmaKT5HJdbVltj7+JJQrKgtdQ86au810k5+pCymCT
         mi2od3e+swwf1AB9R/twATfHiw3NzyMb7N4klK1voXHFwTrCn8n8lzcXq7Myzt8oz+Ig
         yZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E6CBG18rLLwer67fpLmRifuggE8h6Z/cX/LJkNlPt6c=;
        b=N32W05VrSxrbxj1YpOMBiWvDLQ64HkdSF8cnhFlgaTeDpIw4nYKzuYN8BlSSX2dIOu
         L8yTcJ/VJ8j28Yam6UyYZ96HH7DDDI4wIc+avZl8/52tGKccWwoPuN7F1uILTipj8brb
         FY7P5lP1wuAtrBEXCjzAviONGo3yP/tzooB67LE61bd3dkMxphnnmTgCil/+pXjxfl0J
         qq0P1gUozo5ynbAJiyhFCgfNxFpOy4fYMXso8LJgZJZmHdgdsQgB9vAdvsCQF854mj3B
         A+x8QOUdJl3iV2xeb+2Q9M46nRf/h4ZqV5kc2uovEBczoqQwCSnV2ZxGtu15WF9d8Lad
         SD1w==
X-Gm-Message-State: AOAM533V8UJ3fxYrelzjcEhyKIkssBrAj/Ke9yaEsV8JnHWvZcLd+E5p
        oeE9f0Zp0Njd5rSJHe+YHXktxVODzSBUavo0L4J6ZQ==
X-Google-Smtp-Source: ABdhPJxA1e8SqAY/yK1ulaJDroP++PzLoXapWVVDezszGKyuBuh6u3gZbj3fgX62iCcVk7Ubd1NYX6ivb7izxkxskfk=
X-Received: by 2002:a5b:108:: with SMTP id 8mr46111133ybx.174.1629741020718;
 Mon, 23 Aug 2021 10:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210821134004.363217-1-mdevaev@gmail.com>
In-Reply-To: <20210821134004.363217-1-mdevaev@gmail.com>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date:   Mon, 23 Aug 2021 19:50:08 +0200
Message-ID: <CANP3RGffmZi+dJy1GWf7CnnA189RFNwg1ScsTve_6HniJOkydw@mail.gmail.com>
Subject: Re: [PATCH v3] usb: gadget: f_hid: optional SETUP/SET_REPORT mode
To:     Maxim Devaev <mdevaev@gmail.com>
Cc:     balbi@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ruslan.bilovol@gmail.com, mika.westerberg@linux.intel.com,
        jj251510319013@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 21, 2021 at 3:40 PM Maxim Devaev <mdevaev@gmail.com> wrote:
>
> f_hid provides the OUT Endpoint as only way for receiving reports
> from the host. SETUP/SET_REPORT method is not supported, and this causes
> a number of compatibility problems with various host drivers, especially
> in the case of keyboard emulation using f_hid.
>
>   - Some hosts do not support the OUT Endpoint and ignore it,
>     so it becomes impossible for the gadget to receive a report
>     from the host. In the case of a keyboard, the gadget loses
>     the ability to receive the status of the LEDs.
>
>   - Some BIOSes/UEFIs can't work with HID devices with the OUT Endpoint
>     at all. This may be due to their bugs or incomplete implementation
>     of the HID standard.
>     For example, absolutely all Apple UEFIs can't handle the OUT Endpoint
>     if it goes after IN Endpoint in the descriptor and require the revers=
e
>     order (OUT, IN) which is a violation of the standard.
>     Other hosts either do not initialize gadgets with a descriptor
>     containing the OUT Endpoint completely (like some HP and DELL BIOSes
>     and embedded firmwares like on KVM switches), or initialize them,
>     but will not poll the IN Endpoint.
>
> This patch adds configfs option no_out_endpoint=3D1 to disable
> the OUT Endpoint and allows f_hid to receive reports from the host
> via SETUP/SET_REPORT.
>
> Previously, there was such a feature in f_hid, but it was replaced
> by the OUT Endpoint [1] in the commit 99c515005857 ("usb: gadget: hidg:
> register OUT INT endpoint for SET_REPORT"). So this patch actually
> returns the removed functionality while making it optional.
> For backward compatibility reasons, the OUT Endpoint mode remains
> the default behaviour.
>
>   - The OUT Endpoint mode provides the report queue and reduces
>     USB overhead (eliminating SETUP routine) on transmitting a report
>     from the host.
>
>   - If the SETUP/SET_REPORT mode is used, there is no report queue,
>     so the userspace will only read last report. For classic HID devices
>     like keyboards this is not a problem, since it's intended to transmit
>     the status of the LEDs and only the last report is important.
>     This mode provides better compatibility with strange and buggy
>     host drivers.
>
> Both modes passed USBCV tests. Checking with the USB protocol analyzer
> also confirmed that everything is working as it should and the new mode
> ensures operability in all of the described cases.
>
> Signed-off-by: Maxim Devaev <mdevaev@gmail.com>
> Link: https://www.spinics.net/lists/linux-usb/msg65494.html [1]
> ---
>  drivers/usb/gadget/function/f_hid.c | 220 +++++++++++++++++++++++-----
>  drivers/usb/gadget/function/u_hid.h |   1 +
>  2 files changed, 188 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/fun=
ction/f_hid.c
> index bb476e121eae..ca0a7d9eaa34 100644
> --- a/drivers/usb/gadget/function/f_hid.c
> +++ b/drivers/usb/gadget/function/f_hid.c
> @@ -45,12 +45,25 @@ struct f_hidg {
>         unsigned short                  report_desc_length;
>         char                            *report_desc;
>         unsigned short                  report_length;
> +       /*
> +        * use_out_ep - if true, the OUT Endpoint (interrupt out method)
> +        *              will be used to receive reports from the host
> +        *              using functions with the "intout" suffix.
> +        *              Otherwise, the OUT Endpoint will not be configure=
d
> +        *              and the SETUP/SET_REPORT method ("ssreport" suffi=
x)
> +        *              will be used to receive reports.
> +        */
> +       bool                            use_out_ep;
>
>         /* recv report */
> -       struct list_head                completed_out_req;
>         spinlock_t                      read_spinlock;
>         wait_queue_head_t               read_queue;
> +       /* recv report - interrupt out only (use_out_ep =3D=3D 1) */
> +       struct list_head                completed_out_req;
>         unsigned int                    qlen;
> +       /* recv report - setup set_report only (use_out_ep =3D=3D 0) */
> +       char                            *set_report_buf;
> +       unsigned int                    set_report_length;
>
>         /* send report */
>         spinlock_t                      write_spinlock;
> @@ -79,7 +92,7 @@ static struct usb_interface_descriptor hidg_interface_d=
esc =3D {
>         .bDescriptorType        =3D USB_DT_INTERFACE,
>         /* .bInterfaceNumber    =3D DYNAMIC */
>         .bAlternateSetting      =3D 0,
> -       .bNumEndpoints          =3D 2,
> +       /* .bNumEndpoints       =3D DYNAMIC (depends on use_out_ep) */
>         .bInterfaceClass        =3D USB_CLASS_HID,
>         /* .bInterfaceSubClass  =3D DYNAMIC */
>         /* .bInterfaceProtocol  =3D DYNAMIC */
> @@ -140,7 +153,7 @@ static struct usb_ss_ep_comp_descriptor hidg_ss_out_c=
omp_desc =3D {
>         /* .wBytesPerInterval   =3D DYNAMIC */
>  };
>
> -static struct usb_descriptor_header *hidg_ss_descriptors[] =3D {
> +static struct usb_descriptor_header *hidg_ss_descriptors_intout[] =3D {
>         (struct usb_descriptor_header *)&hidg_interface_desc,
>         (struct usb_descriptor_header *)&hidg_desc,
>         (struct usb_descriptor_header *)&hidg_ss_in_ep_desc,
> @@ -150,6 +163,14 @@ static struct usb_descriptor_header *hidg_ss_descrip=
tors[] =3D {
>         NULL,
>  };
>
> +static struct usb_descriptor_header *hidg_ss_descriptors_ssreport[] =3D =
{
> +       (struct usb_descriptor_header *)&hidg_interface_desc,
> +       (struct usb_descriptor_header *)&hidg_desc,
> +       (struct usb_descriptor_header *)&hidg_ss_in_ep_desc,
> +       (struct usb_descriptor_header *)&hidg_ss_in_comp_desc,
> +       NULL,
> +};
> +
>  /* High-Speed Support */
>
>  static struct usb_endpoint_descriptor hidg_hs_in_ep_desc =3D {
> @@ -176,7 +197,7 @@ static struct usb_endpoint_descriptor hidg_hs_out_ep_=
desc =3D {
>                                       */
>  };
>
> -static struct usb_descriptor_header *hidg_hs_descriptors[] =3D {
> +static struct usb_descriptor_header *hidg_hs_descriptors_intout[] =3D {
>         (struct usb_descriptor_header *)&hidg_interface_desc,
>         (struct usb_descriptor_header *)&hidg_desc,
>         (struct usb_descriptor_header *)&hidg_hs_in_ep_desc,
> @@ -184,6 +205,13 @@ static struct usb_descriptor_header *hidg_hs_descrip=
tors[] =3D {
>         NULL,
>  };
>
> +static struct usb_descriptor_header *hidg_hs_descriptors_ssreport[] =3D =
{
> +       (struct usb_descriptor_header *)&hidg_interface_desc,
> +       (struct usb_descriptor_header *)&hidg_desc,
> +       (struct usb_descriptor_header *)&hidg_hs_in_ep_desc,
> +       NULL,
> +};
> +
>  /* Full-Speed Support */
>
>  static struct usb_endpoint_descriptor hidg_fs_in_ep_desc =3D {
> @@ -210,7 +238,7 @@ static struct usb_endpoint_descriptor hidg_fs_out_ep_=
desc =3D {
>                                        */
>  };
>
> -static struct usb_descriptor_header *hidg_fs_descriptors[] =3D {
> +static struct usb_descriptor_header *hidg_fs_descriptors_intout[] =3D {
>         (struct usb_descriptor_header *)&hidg_interface_desc,
>         (struct usb_descriptor_header *)&hidg_desc,
>         (struct usb_descriptor_header *)&hidg_fs_in_ep_desc,
> @@ -218,6 +246,13 @@ static struct usb_descriptor_header *hidg_fs_descrip=
tors[] =3D {
>         NULL,
>  };
>
> +static struct usb_descriptor_header *hidg_fs_descriptors_ssreport[] =3D =
{
> +       (struct usb_descriptor_header *)&hidg_interface_desc,
> +       (struct usb_descriptor_header *)&hidg_desc,
> +       (struct usb_descriptor_header *)&hidg_fs_in_ep_desc,
> +       NULL,
> +};
> +
>  /*----------------------------------------------------------------------=
---*/
>  /*                                 Strings                              =
   */
>
> @@ -241,8 +276,8 @@ static struct usb_gadget_strings *ct_func_strings[] =
=3D {
>  /*----------------------------------------------------------------------=
---*/
>  /*                              Char Device                             =
   */
>
> -static ssize_t f_hidg_read(struct file *file, char __user *buffer,
> -                       size_t count, loff_t *ptr)
> +static ssize_t f_hidg_intout_read(struct file *file, char __user *buffer=
,
> +                                 size_t count, loff_t *ptr)
>  {
>         struct f_hidg *hidg =3D file->private_data;
>         struct f_hidg_req_list *list;
> @@ -255,15 +290,15 @@ static ssize_t f_hidg_read(struct file *file, char =
__user *buffer,
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
> -               if (wait_event_interruptible(hidg->read_queue, READ_COND)=
)
> +               if (wait_event_interruptible(hidg->read_queue, READ_COND_=
INTOUT))
>                         return -ERESTARTSYS;
>
>                 spin_lock_irqsave(&hidg->read_spinlock, flags);
> @@ -313,6 +348,60 @@ static ssize_t f_hidg_read(struct file *file, char _=
_user *buffer,
>         return count;
>  }
>
> +#define READ_COND_SSREPORT (hidg->set_report_buf !=3D NULL)
> +
> +static ssize_t f_hidg_ssreport_read(struct file *file, char __user *buff=
er,
> +                                   size_t count, loff_t *ptr)
> +{
> +       struct f_hidg *hidg =3D file->private_data;
> +       char *tmp_buf =3D NULL;
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
> +               if (wait_event_interruptible(hidg->read_queue, READ_COND_=
SSREPORT))
> +                       return -ERESTARTSYS;
> +
> +               spin_lock_irqsave(&hidg->read_spinlock, flags);
> +       }
> +
> +       count =3D min_t(unsigned int, count, hidg->set_report_length);
> +       tmp_buf =3D hidg->set_report_buf;
> +       hidg->set_report_buf =3D NULL;
> +
> +       spin_unlock_irqrestore(&hidg->read_spinlock, flags);
> +
> +       if (tmp_buf !=3D NULL) {
> +               count -=3D copy_to_user(buffer, tmp_buf, count);
> +               kfree(tmp_buf);
> +       } else {
> +               count =3D -ENOMEM;
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
> +       struct f_hidg *hidg =3D file->private_data;
> +
> +       if (hidg->use_out_ep)
> +               return f_hidg_intout_read(file, buffer, count, ptr);
> +       else
> +               return f_hidg_ssreport_read(file, buffer, count, ptr);
> +}
> +
>  static void f_hidg_req_complete(struct usb_ep *ep, struct usb_request *r=
eq)
>  {
>         struct f_hidg *hidg =3D (struct f_hidg *)ep->driver_data;
> @@ -433,14 +522,20 @@ static __poll_t f_hidg_poll(struct file *file, poll=
_table *wait)
>         if (WRITE_COND)
>                 ret |=3D EPOLLOUT | EPOLLWRNORM;
>
> -       if (READ_COND)
> -               ret |=3D EPOLLIN | EPOLLRDNORM;
> +       if (hidg->use_out_ep) {
> +               if (READ_COND_INTOUT)
> +                       ret |=3D EPOLLIN | EPOLLRDNORM;
> +       } else {
> +               if (READ_COND_SSREPORT)
> +                       ret |=3D EPOLLIN | EPOLLRDNORM;
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
> @@ -467,7 +562,7 @@ static inline struct usb_request *hidg_alloc_ep_req(s=
truct usb_ep *ep,
>         return alloc_ep_req(ep, length);
>  }
>
> -static void hidg_set_report_complete(struct usb_ep *ep, struct usb_reque=
st *req)
> +static void hidg_intout_complete(struct usb_ep *ep, struct usb_request *=
req)
>  {
>         struct f_hidg *hidg =3D (struct f_hidg *) req->context;
>         struct usb_composite_dev *cdev =3D hidg->func.config->cdev;
> @@ -502,6 +597,37 @@ static void hidg_set_report_complete(struct usb_ep *=
ep, struct usb_request *req)
>         }
>  }
>
> +static void hidg_ssreport_complete(struct usb_ep *ep, struct usb_request=
 *req)
> +{
> +       struct f_hidg *hidg =3D (struct f_hidg *)req->context;
> +       struct usb_composite_dev *cdev =3D hidg->func.config->cdev;
> +       char *new_buf =3D NULL;
> +       unsigned long flags;
> +
> +       if (req->status !=3D 0 || req->buf =3D=3D NULL || req->actual =3D=
=3D 0) {
> +               ERROR(cdev,
> +                     "%s FAILED: status=3D%d, buf=3D%p, actual=3D%d\n",
> +                     __func__, req->status, req->buf, req->actual);
> +               return;
> +       }
> +
> +       spin_lock_irqsave(&hidg->read_spinlock, flags);
> +
> +       new_buf =3D krealloc(hidg->set_report_buf, req->actual, GFP_ATOMI=
C);
> +       if (new_buf =3D=3D NULL) {
> +               spin_unlock_irqrestore(&hidg->read_spinlock, flags);
> +               return;
> +       }
> +       hidg->set_report_buf =3D new_buf;
> +
> +       hidg->set_report_length =3D req->actual;
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
>                 VDBG(cdev, "set_report | wLength=3D%d\n", ctrl->wLength);
> -               goto stall;
> +               if (hidg->use_out_ep)
> +                       goto stall;
> +               req->complete =3D hidg_ssreport_complete;
> +               req->context  =3D hidg;
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
> -       list_for_each_entry_safe(list, next, &hidg->completed_out_req, li=
st) {
> -               free_ep_req(hidg->out_ep, list->req);
> -               list_del(&list->list);
> -               kfree(list);
> +       if (hidg->out_ep) {
> +               usb_ep_disable(hidg->out_ep);
> +
> +               spin_lock_irqsave(&hidg->read_spinlock, flags);
> +               list_for_each_entry_safe(list, next, &hidg->completed_out=
_req, list) {
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
> @@ -691,8 +824,7 @@ static int hidg_set_alt(struct usb_function *f, unsig=
ned intf, unsigned alt)
>                 }
>         }
>
> -
> -       if (hidg->out_ep !=3D NULL) {
> +       if (hidg->use_out_ep && hidg->out_ep !=3D NULL) {
>                 /* restart endpoint */
>                 usb_ep_disable(hidg->out_ep);
>
> @@ -717,7 +849,7 @@ static int hidg_set_alt(struct usb_function *f, unsig=
ned intf, unsigned alt)
>                                         hidg_alloc_ep_req(hidg->out_ep,
>                                                           hidg->report_le=
ngth);
>                         if (req) {
> -                               req->complete =3D hidg_set_report_complet=
e;
> +                               req->complete =3D hidg_intout_complete;
>                                 req->context  =3D hidg;
>                                 status =3D usb_ep_queue(hidg->out_ep, req=
,
>                                                       GFP_ATOMIC);
> @@ -743,7 +875,8 @@ static int hidg_set_alt(struct usb_function *f, unsig=
ned intf, unsigned alt)
>         }
>         return 0;
>  disable_out_ep:
> -       usb_ep_disable(hidg->out_ep);
> +       if (hidg->out_ep)
> +               usb_ep_disable(hidg->out_ep);
>  free_req_in:
>         if (req_in)
>                 free_ep_req(hidg->in_ep, req_in);
> @@ -795,14 +928,21 @@ static int hidg_bind(struct usb_configuration *c, s=
truct usb_function *f)
>                 goto fail;
>         hidg->in_ep =3D ep;
>
> -       ep =3D usb_ep_autoconfig(c->cdev->gadget, &hidg_fs_out_ep_desc);
> -       if (!ep)
> -               goto fail;
> -       hidg->out_ep =3D ep;
> +       hidg->out_ep =3D NULL;
> +       if (hidg->use_out_ep) {
> +               ep =3D usb_ep_autoconfig(c->cdev->gadget, &hidg_fs_out_ep=
_desc);
> +               if (!ep)
> +                       goto fail;
> +               hidg->out_ep =3D ep;
> +       }
> +
> +       /* used only if use_out_ep =3D=3D 1 */
> +       hidg->set_report_buf =3D NULL;
>
>         /* set descriptor dynamic values */
>         hidg_interface_desc.bInterfaceSubClass =3D hidg->bInterfaceSubCla=
ss;
>         hidg_interface_desc.bInterfaceProtocol =3D hidg->bInterfaceProtoc=
ol;
> +       hidg_interface_desc.bNumEndpoints =3D hidg->use_out_ep ? 2 : 1;
>         hidg->protocol =3D HID_REPORT_PROTOCOL;
>         hidg->idle =3D 1;
>         hidg_ss_in_ep_desc.wMaxPacketSize =3D cpu_to_le16(hidg->report_le=
ngth);
> @@ -833,9 +973,19 @@ static int hidg_bind(struct usb_configuration *c, st=
ruct usb_function *f)
>         hidg_ss_out_ep_desc.bEndpointAddress =3D
>                 hidg_fs_out_ep_desc.bEndpointAddress;
>
> -       status =3D usb_assign_descriptors(f, hidg_fs_descriptors,
> -                       hidg_hs_descriptors, hidg_ss_descriptors,
> -                       hidg_ss_descriptors);
> +       if (hidg->use_out_ep)
> +               status =3D usb_assign_descriptors(f,
> +                       hidg_fs_descriptors_intout,
> +                       hidg_hs_descriptors_intout,
> +                       hidg_ss_descriptors_intout,
> +                       hidg_ss_descriptors_intout);
> +       else
> +               status =3D usb_assign_descriptors(f,
> +                       hidg_fs_descriptors_ssreport,
> +                       hidg_hs_descriptors_ssreport,
> +                       hidg_ss_descriptors_ssreport,
> +                       hidg_ss_descriptors_ssreport);
> +
>         if (status)
>                 goto fail;
>
> @@ -950,6 +1100,7 @@ CONFIGFS_ATTR(f_hid_opts_, name)
>
>  F_HID_OPT(subclass, 8, 255);
>  F_HID_OPT(protocol, 8, 255);
> +F_HID_OPT(no_out_endpoint, 8, 1);
>  F_HID_OPT(report_length, 16, 65535);
>
>  static ssize_t f_hid_opts_report_desc_show(struct config_item *item, cha=
r *page)
> @@ -1009,6 +1160,7 @@ CONFIGFS_ATTR_RO(f_hid_opts_, dev);
>  static struct configfs_attribute *hid_attrs[] =3D {
>         &f_hid_opts_attr_subclass,
>         &f_hid_opts_attr_protocol,
> +       &f_hid_opts_attr_no_out_endpoint,
>         &f_hid_opts_attr_report_length,
>         &f_hid_opts_attr_report_desc,
>         &f_hid_opts_attr_dev,
> @@ -1093,6 +1245,7 @@ static void hidg_free(struct usb_function *f)
>         hidg =3D func_to_hidg(f);
>         opts =3D container_of(f->fi, struct f_hid_opts, func_inst);
>         kfree(hidg->report_desc);
> +       kfree(hidg->set_report_buf);
>         kfree(hidg);
>         mutex_lock(&opts->lock);
>         --opts->refcnt;
> @@ -1139,6 +1292,7 @@ static struct usb_function *hidg_alloc(struct usb_f=
unction_instance *fi)
>                         return ERR_PTR(-ENOMEM);
>                 }
>         }
> +       hidg->use_out_ep =3D !opts->no_out_endpoint;
>
>         mutex_unlock(&opts->lock);
>
> diff --git a/drivers/usb/gadget/function/u_hid.h b/drivers/usb/gadget/fun=
ction/u_hid.h
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

Reviewed-by: Maciej =C5=BBenczykowski <zenczykowski@gmail.com>
