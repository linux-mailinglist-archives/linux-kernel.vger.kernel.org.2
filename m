Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A1035F7FD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 17:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbhDNPks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 11:40:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27328 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233528AbhDNPkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 11:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618414815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pi5yOQUDoReZsXwr9Sn8UurhM0qHhwzfJF8qj5AgWWw=;
        b=YWiM5M5yqKtCub3qUeJ3eqBF/boyNC1+ZcKvOxhVLxFIG2pI+AwbveXVueJwDXY6xP8kwA
        XyZg7gvbnqPMSqebF62x6EVZb7T4dfSL7Rb+kBHviux81X0DyQCZDSzS4DGdIv9yISM18b
        NWqEiivxCk6PiBj5qsfeeXYdpRYvaKA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-_psWLaNdP7utm56goOMWhw-1; Wed, 14 Apr 2021 11:40:14 -0400
X-MC-Unique: _psWLaNdP7utm56goOMWhw-1
Received: by mail-qt1-f197.google.com with SMTP id s20-20020ac85cd40000b029019d65c35b39so2184758qta.19
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 08:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Pi5yOQUDoReZsXwr9Sn8UurhM0qHhwzfJF8qj5AgWWw=;
        b=LuiYY4r31dUmo2feHqxTE3pz4BGiZKQFtnxCUQNb7i+TsyViJZ4uHQ/iXYNZnG1ikA
         Sw+1sVBOz4v7OSbKaMVB+O4IIUBYhf8QV39F9QeSIzvg1Tx3vM+v/YyWHW1S9QLVvKSh
         ElEPdCZabvKdKX0BBI4fuXhZxbh1Bp5jSy/m+hPMTOHeEZswebMFnvHtIihRof1jCCDr
         U3jSrOIPWcHliNK8ZAbhhZP+97KDT+M4GAVrK7032l9oUiA+cT/7P4LxXZ+nzeWXh+UC
         o9UYgnTS/TDsNGDwy6va3ECbJfepmoJiYt2ifBmOgPtMqexnKey/LEffXxnAyd8DWm0w
         lkdQ==
X-Gm-Message-State: AOAM533WdK/sWX9IPoZv5qsA5yMp+fEtHq3ebebErMsDCXQ3aIhoqUHR
        BZg22BW9AzSJI209l5QY5UP6VsjqWb9eg/ns2OXZnoqqBibC+MShU8RHriU3Ty/9N/IZokFk/Mg
        cH4TTFm4xSup7ogtUvyDf/vfV
X-Received: by 2002:a37:9cd8:: with SMTP id f207mr23703958qke.230.1618414813905;
        Wed, 14 Apr 2021 08:40:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyY35VesErlxzK/29gR2uI8QR4WnSYD4fBVsD2tb8c8xNAedUoKAwTr+GjfzS/O/zwQqRPunQ==
X-Received: by 2002:a37:9cd8:: with SMTP id f207mr23703929qke.230.1618414813622;
        Wed, 14 Apr 2021 08:40:13 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s19sm12311648qks.130.2021.04.14.08.40.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 08:40:13 -0700 (PDT)
Subject: Re: [PATCH V4 XRT Alveo 09/20] fpga: xrt: management physical
 function driver (root)
To:     Max Zhen <max.zhen@xilinx.com>, Lizhi Hou <lizhi.hou@xilinx.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-fpga@vger.kernel.org, sonal.santan@xilinx.com,
        yliu@xilinx.com, michal.simek@xilinx.com, stefanos@xilinx.com,
        devicetree@vger.kernel.org, mdf@kernel.org, robh@kernel.org
References: <20210324052947.27889-1-lizhi.hou@xilinx.com>
 <20210324052947.27889-10-lizhi.hou@xilinx.com>
 <5ac8ef15-87b4-358b-0835-d41e3b88592b@redhat.com>
 <f38c7210-85aa-09af-9a52-ebb13ca3442e@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <9a1a3d6e-3a5d-2272-7235-d46d09589cf8@redhat.com>
Date:   Wed, 14 Apr 2021 08:40:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <f38c7210-85aa-09af-9a52-ebb13ca3442e@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/9/21 11:50 AM, Max Zhen wrote:
> Hi Tom,
>
>
> On 3/31/21 6:03 AM, Tom Rix wrote:
>> On 3/23/21 10:29 PM, Lizhi Hou wrote:
>>> The PCIE device driver which attaches to management function on Alveo
>>> devices. It instantiates one or more group drivers which, in turn,
>>> instantiate platform drivers. The instantiation of group and platform
>>> drivers is completely dtb driven.
>>>
>>> Signed-off-by: Sonal Santan<sonal.santan@xilinx.com>
>>> Signed-off-by: Max Zhen<max.zhen@xilinx.com>
>>> Signed-off-by: Lizhi Hou<lizhi.hou@xilinx.com>
>>> ---
>>>   drivers/fpga/xrt/mgmt/root.c | 333 
>>> +++++++++++++++++++++++++++++++++++
>>>   1 file changed, 333 insertions(+)
>>>   create mode 100644 drivers/fpga/xrt/mgmt/root.c
>>>
>>> diff --git a/drivers/fpga/xrt/mgmt/root.c 
>>> b/drivers/fpga/xrt/mgmt/root.c
>>> new file mode 100644
>>> index 000000000000..f97f92807c01
>>> --- /dev/null
>>> +++ b/drivers/fpga/xrt/mgmt/root.c
>>> @@ -0,0 +1,333 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Xilinx Alveo Management Function Driver
>>> + *
>>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>>> + *
>>> + * Authors:
>>> + *   Cheng Zhen<maxz@xilinx.com>
>>> + */
>>> +
>>> +#include <linux/module.h>
>>> +#include <linux/pci.h>
>>> +#include <linux/aer.h>
>>> +#include <linux/vmalloc.h>
>>> +#include <linux/delay.h>
>>> +
>>> +#include "xroot.h"
>>> +#include "xmgnt.h"
>>> +#include "metadata.h"
>>> +
>>> +#define XMGMT_MODULE_NAME    "xrt-mgmt"
>> ok
>>> +#define XMGMT_DRIVER_VERSION "4.0.0"
>>> +
>>> +#define XMGMT_PDEV(xm)               ((xm)->pdev)
>>> +#define XMGMT_DEV(xm) (&(XMGMT_PDEV(xm)->dev))
>>> +#define xmgmt_err(xm, fmt, args...)  \
>>> +     dev_err(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
>>> +#define xmgmt_warn(xm, fmt, args...) \
>>> +     dev_warn(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
>>> +#define xmgmt_info(xm, fmt, args...) \
>>> +     dev_info(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
>>> +#define xmgmt_dbg(xm, fmt, args...)  \
>>> +     dev_dbg(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
>>> +#define XMGMT_DEV_ID(_pcidev)                        \
>>> +     ({ typeof(_pcidev) (pcidev) = (_pcidev);        \
>>> +     ((pci_domain_nr((pcidev)->bus) << 16) | \
>>> +     PCI_DEVID((pcidev)->bus->number, 0)); })
>>> +
>>> +static struct class *xmgmt_class;
>>> +
>>> +/* PCI Device IDs */
>> add a comment on what a golden image is here something like
>>
>> /*
>>
>> * Golden image is preloaded on the device when it is shipped to 
>> customer.
>>
>> * Then, customer can load other shells (from Xilinx or some other 
>> vendor).
>>
>> * If something goes wrong with the shell, customer can always go back to
>>
>> * golden and start over again.
>>
>> */
>>
>
> Will do.
>
>
>>> +#define PCI_DEVICE_ID_U50_GOLDEN 0xD020
>>> +#define PCI_DEVICE_ID_U50            0x5020
>>> +static const struct pci_device_id xmgmt_pci_ids[] = {
>>> +     { PCI_DEVICE(PCI_VENDOR_ID_XILINX, PCI_DEVICE_ID_U50_GOLDEN), 
>>> }, /* Alveo U50 (golden) */
>>> +     { PCI_DEVICE(PCI_VENDOR_ID_XILINX, PCI_DEVICE_ID_U50), }, /* 
>>> Alveo U50 */
>>> +     { 0, }
>>> +};
>>> +
>>> +struct xmgmt {
>>> +     struct pci_dev *pdev;
>>> +     void *root;
>>> +
>>> +     bool ready;
>>> +};
>>> +
>>> +static int xmgmt_config_pci(struct xmgmt *xm)
>>> +{
>>> +     struct pci_dev *pdev = XMGMT_PDEV(xm);
>>> +     int rc;
>>> +
>>> +     rc = pcim_enable_device(pdev);
>>> +     if (rc < 0) {
>>> +             xmgmt_err(xm, "failed to enable device: %d", rc);
>>> +             return rc;
>>> +     }
>>> +
>>> +     rc = pci_enable_pcie_error_reporting(pdev);
>>> +     if (rc)
>> ok
>>> +             xmgmt_warn(xm, "failed to enable AER: %d", rc);
>>> +
>>> +     pci_set_master(pdev);
>>> +
>>> +     rc = pcie_get_readrq(pdev);
>>> +     if (rc > 512)
>> 512 is magic number, change this to a #define
>
>
> Will do.
>
>
>>> +             pcie_set_readrq(pdev, 512);
>>> +     return 0;
>>> +}
>>> +
>>> +static int xmgmt_match_slot_and_save(struct device *dev, void *data)
>>> +{
>>> +     struct xmgmt *xm = data;
>>> +     struct pci_dev *pdev = to_pci_dev(dev);
>>> +
>>> +     if (XMGMT_DEV_ID(pdev) == XMGMT_DEV_ID(xm->pdev)) {
>>> +             pci_cfg_access_lock(pdev);
>>> +             pci_save_state(pdev);
>>> +     }
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static void xmgmt_pci_save_config_all(struct xmgmt *xm)
>>> +{
>>> +     bus_for_each_dev(&pci_bus_type, NULL, xm, 
>>> xmgmt_match_slot_and_save);
>> refactor expected in v5 when pseudo bus change happens.
>
>
> There might be some mis-understanding here...
>
> No matter how we reorganize our code (using platform_device bus type 
> or defining our own bus type), it's a driver that drives a PCIE device 
> after all. So, this mgmt/root.c must be a PCIE driver, which may 
> interact with a whole bunch of IP drivers through a pseudo bus we are 
> about to create.
>
> What this code is doing here is completely of PCIE business (PCIE 
> config space access). So, I think it is appropriate code in a PCIE 
> driver.
>
> The PCIE device we are driving is a multi-function device. The mgmt pf 
> is of function 0, which, according to PCIE spec, can manage other 
> functions on the same device. So, I think it's appropriate for mgmt pf 
> driver (this root driver) to find it's peer function (through PCIE bus 
> type) on the same device and do something about it in certain special 
> cases.
>
> Please let me know why you expect this code to be refactored and how 
> you want it to be refactored. I might have missed something here...
>
ok, i get it.

thanks for the explanation.

Tom

>
>>> +}
>>> +
>>> +static int xmgmt_match_slot_and_restore(struct device *dev, void 
>>> *data)
>>> +{
>>> +     struct xmgmt *xm = data;
>>> +     struct pci_dev *pdev = to_pci_dev(dev);
>>> +
>>> +     if (XMGMT_DEV_ID(pdev) == XMGMT_DEV_ID(xm->pdev)) {
>>> +             pci_restore_state(pdev);
>>> +             pci_cfg_access_unlock(pdev);
>>> +     }
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static void xmgmt_pci_restore_config_all(struct xmgmt *xm)
>>> +{
>>> +     bus_for_each_dev(&pci_bus_type, NULL, xm, 
>>> xmgmt_match_slot_and_restore);
>>> +}
>>> +
>>> +static void xmgmt_root_hot_reset(struct pci_dev *pdev)
>>> +{
>>> +     struct xmgmt *xm = pci_get_drvdata(pdev);
>>> +     struct pci_bus *bus;
>>> +     u8 pci_bctl;
>>> +     u16 pci_cmd, devctl;
>>> +     int i, ret;
>>> +
>>> +     xmgmt_info(xm, "hot reset start");
>>> +
>>> +     xmgmt_pci_save_config_all(xm);
>>> +
>>> +     pci_disable_device(pdev);
>>> +
>>> +     bus = pdev->bus;
>> whitespace, all these nl's are not needed
>
>
> Will remove them.
>
>
>>> +
>>> +     /*
>>> +      * When flipping the SBR bit, device can fall off the bus. 
>>> This is
>>> +      * usually no problem at all so long as drivers are working 
>>> properly
>>> +      * after SBR. However, some systems complain bitterly when the 
>>> device
>>> +      * falls off the bus.
>>> +      * The quick solution is to temporarily disable the SERR 
>>> reporting of
>>> +      * switch port during SBR.
>>> +      */
>>> +
>>> +     pci_read_config_word(bus->self, PCI_COMMAND, &pci_cmd);
>>> +     pci_write_config_word(bus->self, PCI_COMMAND, (pci_cmd & 
>>> ~PCI_COMMAND_SERR));
>>> +     pcie_capability_read_word(bus->self, PCI_EXP_DEVCTL, &devctl);
>>> +     pcie_capability_write_word(bus->self, PCI_EXP_DEVCTL, (devctl 
>>> & ~PCI_EXP_DEVCTL_FERE));
>>> +     pci_read_config_byte(bus->self, PCI_BRIDGE_CONTROL, &pci_bctl);
>>> +     pci_write_config_byte(bus->self, PCI_BRIDGE_CONTROL, pci_bctl 
>>> | PCI_BRIDGE_CTL_BUS_RESET);
>> ok
>>> +     msleep(100);
>>> +     pci_write_config_byte(bus->self, PCI_BRIDGE_CONTROL, pci_bctl);
>>> +     ssleep(1);
>>> +
>>> +     pcie_capability_write_word(bus->self, PCI_EXP_DEVCTL, devctl);
>>> +     pci_write_config_word(bus->self, PCI_COMMAND, pci_cmd);
>>> +
>>> +     ret = pci_enable_device(pdev);
>>> +     if (ret)
>>> +             xmgmt_err(xm, "failed to enable device, ret %d", ret);
>>> +
>>> +     for (i = 0; i < 300; i++) {
>>> +             pci_read_config_word(pdev, PCI_COMMAND, &pci_cmd);
>>> +             if (pci_cmd != 0xffff)
>>> +                     break;
>>> +             msleep(20);
>>> +     }
>>> +     if (i == 300)
>>> +             xmgmt_err(xm, "time'd out waiting for device to be 
>>> online after reset");
>> time'd -> timed
>
>
> Will do.
>
>
> Thanks,
>
> Max
>
>> Tom
>>
>>> +
>>> +     xmgmt_info(xm, "waiting for %d ms", i * 20);
>>> +     xmgmt_pci_restore_config_all(xm);
>>> +     xmgmt_config_pci(xm);
>>> +}
>>> +
>>> +static int xmgmt_create_root_metadata(struct xmgmt *xm, char 
>>> **root_dtb)
>>> +{
>>> +     char *dtb = NULL;
>>> +     int ret;
>>> +
>>> +     ret = xrt_md_create(XMGMT_DEV(xm), &dtb);
>>> +     if (ret) {
>>> +             xmgmt_err(xm, "create metadata failed, ret %d", ret);
>>> +             goto failed;
>>> +     }
>>> +
>>> +     ret = xroot_add_vsec_node(xm->root, dtb);
>>> +     if (ret == -ENOENT) {
>>> +             /*
>>> +              * We may be dealing with a MFG board.
>>> +              * Try vsec-golden which will bring up all hard-coded 
>>> leaves
>>> +              * at hard-coded offsets.
>>> +              */
>>> +             ret = xroot_add_simple_node(xm->root, dtb, 
>>> XRT_MD_NODE_VSEC_GOLDEN);
>>> +     } else if (ret == 0) {
>>> +             ret = xroot_add_simple_node(xm->root, dtb, 
>>> XRT_MD_NODE_MGMT_MAIN);
>>> +     }
>>> +     if (ret)
>>> +             goto failed;
>>> +
>>> +     *root_dtb = dtb;
>>> +     return 0;
>>> +
>>> +failed:
>>> +     vfree(dtb);
>>> +     return ret;
>>> +}
>>> +
>>> +static ssize_t ready_show(struct device *dev,
>>> +                       struct device_attribute *da,
>>> +                       char *buf)
>>> +{
>>> +     struct pci_dev *pdev = to_pci_dev(dev);
>>> +     struct xmgmt *xm = pci_get_drvdata(pdev);
>>> +
>>> +     return sprintf(buf, "%d\n", xm->ready);
>>> +}
>>> +static DEVICE_ATTR_RO(ready);
>>> +
>>> +static struct attribute *xmgmt_root_attrs[] = {
>>> +     &dev_attr_ready.attr,
>>> +     NULL
>>> +};
>>> +
>>> +static struct attribute_group xmgmt_root_attr_group = {
>>> +     .attrs = xmgmt_root_attrs,
>>> +};
>>> +
>>> +static struct xroot_physical_function_callback xmgmt_xroot_pf_cb = {
>>> +     .xpc_hot_reset = xmgmt_root_hot_reset,
>>> +};
>>> +
>>> +static int xmgmt_probe(struct pci_dev *pdev, const struct 
>>> pci_device_id *id)
>>> +{
>>> +     int ret;
>>> +     struct device *dev = &pdev->dev;
>>> +     struct xmgmt *xm = devm_kzalloc(dev, sizeof(*xm), GFP_KERNEL);
>>> +     char *dtb = NULL;
>>> +
>>> +     if (!xm)
>>> +             return -ENOMEM;
>>> +     xm->pdev = pdev;
>>> +     pci_set_drvdata(pdev, xm);
>>> +
>>> +     ret = xmgmt_config_pci(xm);
>>> +     if (ret)
>>> +             goto failed;
>>> +
>>> +     ret = xroot_probe(pdev, &xmgmt_xroot_pf_cb, &xm->root);
>>> +     if (ret)
>>> +             goto failed;
>>> +
>>> +     ret = xmgmt_create_root_metadata(xm, &dtb);
>>> +     if (ret)
>>> +             goto failed_metadata;
>>> +
>>> +     ret = xroot_create_group(xm->root, dtb);
>>> +     vfree(dtb);
>>> +     if (ret)
>>> +             xmgmt_err(xm, "failed to create root group: %d", ret);
>>> +
>>> +     if (!xroot_wait_for_bringup(xm->root))
>>> +             xmgmt_err(xm, "failed to bringup all groups");
>>> +     else
>>> +             xm->ready = true;
>>> +
>>> +     ret = sysfs_create_group(&pdev->dev.kobj, 
>>> &xmgmt_root_attr_group);
>>> +     if (ret) {
>>> +             /* Warning instead of failing the probe. */
>>> +             xmgmt_warn(xm, "create xmgmt root attrs failed: %d", 
>>> ret);
>>> +     }
>>> +
>>> +     xroot_broadcast(xm->root, XRT_EVENT_POST_CREATION);
>>> +     xmgmt_info(xm, "%s started successfully", XMGMT_MODULE_NAME);
>>> +     return 0;
>>> +
>>> +failed_metadata:
>>> +     xroot_remove(xm->root);
>>> +failed:
>>> +     pci_set_drvdata(pdev, NULL);
>>> +     return ret;
>>> +}
>>> +
>>> +static void xmgmt_remove(struct pci_dev *pdev)
>>> +{
>>> +     struct xmgmt *xm = pci_get_drvdata(pdev);
>>> +
>>> +     xroot_broadcast(xm->root, XRT_EVENT_PRE_REMOVAL);
>>> +     sysfs_remove_group(&pdev->dev.kobj, &xmgmt_root_attr_group);
>>> +     xroot_remove(xm->root);
>>> +     pci_disable_pcie_error_reporting(xm->pdev);
>>> +     xmgmt_info(xm, "%s cleaned up successfully", XMGMT_MODULE_NAME);
>>> +}
>>> +
>>> +static struct pci_driver xmgmt_driver = {
>>> +     .name = XMGMT_MODULE_NAME,
>>> +     .id_table = xmgmt_pci_ids,
>>> +     .probe = xmgmt_probe,
>>> +     .remove = xmgmt_remove,
>>> +};
>>> +
>>> +static int __init xmgmt_init(void)
>>> +{
>>> +     int res = 0;
>>> +
>>> +     res = xmgmt_register_leaf();
>>> +     if (res)
>>> +             return res;
>>> +
>>> +     xmgmt_class = class_create(THIS_MODULE, XMGMT_MODULE_NAME);
>>> +     if (IS_ERR(xmgmt_class))
>>> +             return PTR_ERR(xmgmt_class);
>>> +
>>> +     res = pci_register_driver(&xmgmt_driver);
>>> +     if (res) {
>>> +             class_destroy(xmgmt_class);
>>> +             return res;
>>> +     }
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static __exit void xmgmt_exit(void)
>>> +{
>>> +     pci_unregister_driver(&xmgmt_driver);
>>> +     class_destroy(xmgmt_class);
>>> +     xmgmt_unregister_leaf();
>>> +}
>>> +
>>> +module_init(xmgmt_init);
>>> +module_exit(xmgmt_exit);
>>> +
>>> +MODULE_DEVICE_TABLE(pci, xmgmt_pci_ids);
>>> +MODULE_VERSION(XMGMT_DRIVER_VERSION);
>>> +MODULE_AUTHOR("XRT Team<runtime@xilinx.com>");
>>> +MODULE_DESCRIPTION("Xilinx Alveo management function driver");
>>> +MODULE_LICENSE("GPL v2");
>

