Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B720E43369D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 15:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235800AbhJSNF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 09:05:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230097AbhJSNF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 09:05:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E51D61074;
        Tue, 19 Oct 2021 13:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634648595;
        bh=qgRAWLYW0NycMT2umN95FMw+Ilc+lTdFmxOcAlt+Dsg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XqEdwIzi1BZZBiEzWjJbrUXRFF7jWfkhcx9CMX1G2c5CJMgcbdeSv8n3yiASQc8Av
         m9VBJidxmnfZwOQoXsUvko4h95N/2bcY8izlmXcNHrLU6GIFnTdrJMWr+5W9PROCZl
         FEvXygg95qnyhQow0mm89w0f3aasZkq188axdgmSk09iVWj0E5nQORyJl8gV52SYES
         Tme36AbVrx3RdRCc2HEdkOVzK/O9k5tez+8+6CsNGMdIFejLV8u0dlwDlgX5kx/OTX
         1bWFa5mp9KCMxCB11nM05uAcfXgE8tQApiGvC2/d7fwrDCXuhONYniagmTPuHFRL5O
         4VPat87CSGO9Q==
Received: by mail-ed1-f41.google.com with SMTP id w19so12572721edd.2;
        Tue, 19 Oct 2021 06:03:14 -0700 (PDT)
X-Gm-Message-State: AOAM531wVfXWX6+Byy2Qmh3Bh+L+qCmmqxD+njE4lmR7g1nwZVqUkl/+
        OMXTYtlVKcyFLU2zO/AFd738xElEK7yuG7L9HA==
X-Google-Smtp-Source: ABdhPJyRA3aRPd0bagua8dmYvTM+nshS6FWmO9KV/73FrrpBWwahMntC8LARckoQRyWiwKIe8Qfnlu9FKOlK80HB69A=
X-Received: by 2002:a17:906:c350:: with SMTP id ci16mr36473934ejb.466.1634648584316;
 Tue, 19 Oct 2021 06:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210802160521.331031-1-lizhi.hou@xilinx.com> <20210802160521.331031-2-lizhi.hou@xilinx.com>
 <20211012050931.GA95330@yilunxu-OptiPlex-7050> <8d8f6c08-6e68-a4b8-4cfd-1dd547f3fe28@xilinx.com>
 <20211014022122.GG95330@yilunxu-OptiPlex-7050> <cc261622-5104-39ae-7221-b33dd70303e5@xilinx.com>
In-Reply-To: <cc261622-5104-39ae-7221-b33dd70303e5@xilinx.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 19 Oct 2021 08:02:52 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKoHomBBzggK0RzoWxPjnvZijS5v6NympozLz62P-NOvA@mail.gmail.com>
Message-ID: <CAL_JsqKoHomBBzggK0RzoWxPjnvZijS5v6NympozLz62P-NOvA@mail.gmail.com>
Subject: Re: [PATCH V9 XRT Alveo 01/14] Documentation: fpga: Add a document
 describing XRT Alveo drivers
To:     Lizhi Hou <lizhi.hou@xilinx.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-fpga@vger.kernel.org, maxz@xilinx.com,
        Sonal Santan <sonal.santan@xilinx.com>, yliu@xilinx.com,
        Michal Simek <michal.simek@xilinx.com>,
        Stefano Stabellini <stefanos@xilinx.com>,
        devicetree@vger.kernel.org, trix@redhat.com,
        Moritz Fischer <mdf@kernel.org>,
        Max Zhen <max.zhen@xilinx.com>, Xu Yilun <yilun.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 11:12 AM Lizhi Hou <lizhi.hou@xilinx.com> wrote:
>
> Hello Rob,
>
> Please help with the review of the proposed FDT usage by Alveo/XRT driver=
s.
>
> Thanks,
> Lizhi
>
> On 10/13/21 7:21 PM, Xu Yilun wrote:
> > CAUTION: This message has originated from an External Source. Please us=
e proper judgment and caution when opening attachments, clicking links, or =
responding to this email.
> >
> >
> >>>> +.. _device_tree_usage:
> >>>> +
> >>>> +Device Tree Usage
> >>>> +-----------------
> >>>> +
> >>>> +The xsabin file stores metadata which advertise HW subsystems prese=
nt in a
> >>>> +partition. The metadata is stored in device tree format with a well=
 defined
> >>>> +schema. XRT management driver uses this information to bind *xrt_dr=
ivers* to
> >>>> +the subsystem instantiations. The xrt_drivers are found in **xrt-li=
b.ko** kernel
> >>>> +module.
> >>> I'm still catching up the patchset from the very beginning, and just
> >>> finished the Documentation part. So far, I see the DT usage concern
> >>> which may impact the architecure a lot, so I should raise it ASAP.
> >>>
> >>> The concern raised by the DT maintainer:
> >>> https://lore.kernel.org/linux-fpga/CAL_JsqLod6FBGFhu7WXtMrB_z7wj8-up0=
EetM1QS9M3gjm8d7Q@mail.gmail.com/
> >>>
> >>> First of all, directly parsing FDT in device drivers is not a normal =
usage of DT
> >>> in linux. It is out of the current DT usage model. So it should be ag=
reed by DT
> >>> maintainers.
> >> Thanks for reviewing XRT document and providing feedback.
> >> Here is the reply from Sonal for Rob=E2=80=99s question:
> >> https://lore.kernel.org/linux-fpga/BY5PR02MB62604B87C66A1AD139A6F153BB=
F40@BY5PR02MB6260.namprd02.prod.outlook.com/
> >> Overall, libfdt is used by XRT driver to parse the metadata which come=
s with
> >> an Alveo board.
> >> When XRT driver discovers an Alveo board, it will read a fdt blob from=
 board
> >> firmware file resident on the host.
> >> By parsing the fdt blob, XRT driver gets information about this Alveo =
board,
> >> such as version, uuid, IPs exposed to PCI BAR, interrupt binding etc.
> >> So libfdt is used simply as Alveo metadata parser here. XRT drivers do=
 not
> >> interact with system wide DT or present the Alveo device tree to host.=
 For
> >> many systems like x86_64, system wide DT is not present but libfdt par=
sing
> >> services will still be needed.
> > Yes, I understand the use case.
> >
> > My concern is, directly parsing an isolated FDT in device driver and
> > populate sub devices, skipping the unflattening, this is a new working
> > model of device tree usage, but for the same purpose as the existing
> > one.
> >
> > So I really need the confirmation of DT maintainers.

Perhaps you could explain why you think you need to use FDT instead of
unflattening. Without that, the answer is don't use FDT.

> >
> >>> Current FPGA framework modifies kernel's live tree by DT overlay, whe=
n FPGA is
> >>> dynamically reprogrammed and new HW devices appear. See
> >>> Documentation/devicetree/bindings/fpga/fpga-region.txt.
> >>>
> >>> Then something less important:
> >>>
> >>>     1. The bindings should be documented in Documentation/devicetree/=
bindings/.

Yes.

> >>>     2. Are all the example DT usage conform to the exsiting bindings?=
 I
> >>>        didn't go through all device classes, but remember like the
> >>>        interrupt-controller should have a "interrupt-controller" prop=
erty, and
> >>>        the PCI properties are also different from PCI bindings.

They don't, but should. I can't tell what you are trying to do here,
but it looks like a mess.

> >> The fdt properties are defined for Alveo firmware files. XRT driver is=
 the
> >> only consumer of this data. I am wondering if
> > Personally I don't like the idea of a different binding definition set,
> > even if the new device tree usage is accepted. We all use device tree
> > for device enumeration, so why the different definitions.
> >
> > Thanks,
> > Yilun
> >
> >> Documentation/devicetree/bindings is the right place for Alveo/XRT pri=
vate
> >> format or should it be documented as part of XRT driver documentation?
> >> Looking for guidance here.
> >>
> >>
> >> Thanks,
> >>
> >> Lizhi
> >>
> >>> Thanks,
> >>> Yilun
> >>>
> >>>> +
> >>>> +Logic UUID
> >>>> +^^^^^^^^^^
> >>>> +A partition is identified uniquely through ``logic_uuid`` property:=
:
> >>>> +
> >>>> +  /dts-v1/;
> >>>> +  / {
> >>>> +      logic_uuid =3D "0123456789abcdef0123456789abcdef";
> >>>> +      ...
> >>>> +    }
> >>>> +
> >>>> +Schema Version
> >>>> +^^^^^^^^^^^^^^
> >>>> +Schema version is defined through the ``schema_version`` node. It c=
ontains
> >>>> +``major`` and ``minor`` properties as below::
> >>>> +
> >>>> +  /dts-v1/;
> >>>> +  / {
> >>>> +       schema_version {
> >>>> +           major =3D <0x01>;
> >>>> +           minor =3D <0x00>;
> >>>> +       };
> >>>> +       ...
> >>>> +    }
> >>>> +
> >>>> +.. _partition_uuids:
> >>>> +
> >>>> +Partition UUIDs
> >>>> +^^^^^^^^^^^^^^^
> >>>> +Each partition may have parent and child UUIDs. These UUIDs are
> >>>> +defined by ``interfaces`` node and ``interface_uuid`` property::
> >>>> +
> >>>> +  /dts-v1/;
> >>>> +  / {
> >>>> +       interfaces {
> >>>> +           @0 {
> >>>> +                  interface_uuid =3D "0123456789abcdef0123456789abc=
def";
> >>>> +           };
> >>>> +           @1 {
> >>>> +                  interface_uuid =3D "fedcba9876543210fedcba9876543=
210";
> >>>> +           };
> >>>> +           ...
> >>>> +        };
> >>>> +       ...
> >>>> +    }
> >>>> +
> >>>> +
> >>>> +Subsystem Instantiations
> >>>> +^^^^^^^^^^^^^^^^^^^^^^^^
> >>>> +Subsystem instantiations are captured as children of ``addressable_=
endpoints``
> >>>> +node::
> >>>> +
> >>>> +  /dts-v1/;
> >>>> +  / {
> >>>> +       addressable_endpoints {
> >>>> +           abc {
> >>>> +               ...
> >>>> +           };
> >>>> +           def {
> >>>> +               ...
> >>>> +           };
> >>>> +           ...
> >>>> +       }
> >>>> +  }
> >>>> +
> >>>> +Subnode 'abc' and 'def' are the name of subsystem nodes
> >>>> +
> >>>> +Subsystem Node
> >>>> +^^^^^^^^^^^^^^
> >>>> +Each subsystem node and its properties define a hardware instance::
> >>>> +
> >>>> +
> >>>> +  addressable_endpoints {
> >>>> +      abc {
> >>>> +          reg =3D <0x00 0x1f05000 0x00 0x1000>>
> >>>> +          pcie_physical_function =3D <0x0>;
> >>>> +          pcie_bar_mapping =3D <0x2>;
> >>>> +          compatible =3D "abc def";
> >>>> +          interrupts =3D <0x09 0x0c>;
> >>>> +          firmware {
> >>>> +              firmware_product_name =3D "abc"
> >>>> +              firmware_branch_name =3D "def"
> >>>> +              firmware_version_major =3D <1>
> >>>> +              firmware_version_minor =3D <2>
> >>>> +          };
> >>>> +      }
> >>>> +      ...
> >>>> +  }
> >>>> +
> >>>> +:reg:
> >>>> + Property defines an address range. `<0x00 0x1f05000 0x00 0x1000>` =
indicates
> >>>> + *0x00 0x1f05000* as BAR offset and *0x00 0x1000* as address length=
.
> >>>> +:pcie_physical_function:
> >>>> + Property specifies which PCIe physical function the subsystem node=
 resides.
> >>>> + `<0x0>` implies physical function 0.
> >>>> +:pcie_bar_mapping:
> >>>> + Property specifies which PCIe BAR the subsystem node resides. `<0x=
2>` implies
> >>>> + BAR 2. A value of 0 means the property is not defined.
> >>>> +:compatible:
> >>>> + Property is a list of strings. The first string in the list specif=
ies the exact
> >>>> + subsystem node. The following strings represent other devices that=
 the device
> >>>> + is compatible with.
> >>>> +:interrupts:
> >>>> + Property specifies start and end interrupts for this subsystem nod=
e.
> >>>> + `<0x09 0x0c>` implies interrupts 9 to 13 are used by this subsyste=
m.
> >>>> +:firmware:
> >>>> + Subnode defines the firmware required by this subsystem node.
> >>>> +
> >>>> +Alveo U50 Platform Example
> >>>> +^^^^^^^^^^^^^^^^^^^^^^^^^^
> >>>> +::
> >>>> +
> >>>> +  /dts-v1/;
> >>>> +
> >>>> +  /{
> >>>> +        logic_uuid =3D "f465b0a3ae8c64f619bc150384ace69b";
> >>>> +
> >>>> +        schema_version {
> >>>> +                major =3D <0x01>;
> >>>> +                minor =3D <0x00>;
> >>>> +        };
> >>>> +
> >>>> +        interfaces {
> >>>> +
> >>>> +                @0 {
> >>>> +                        interface_uuid =3D "862c7020a250293e32036f1=
9956669e5";
> >>>> +                };
> >>>> +        };
> >>>> +
> >>>> +        addressable_endpoints {
> >>>> +
> >>>> +                ep_blp_rom_00 {
> >>>> +                        reg =3D <0x00 0x1f04000 0x00 0x1000>;
> >>>> +                        pcie_physical_function =3D <0x00>;
> >>>> +                        compatible =3D "xilinx.com,reg_abs-axi_bram=
_ctrl-1.0\0axi_bram_ctrl";
> >>>> +                };
> >>>> +
> >>>> +                ep_card_flash_program_00 {
> >>>> +                        reg =3D <0x00 0x1f06000 0x00 0x1000>;
> >>>> +                        pcie_physical_function =3D <0x00>;
> >>>> +                        compatible =3D "xilinx.com,reg_abs-axi_quad=
_spi-1.0\0axi_quad_spi";
> >>>> +                        interrupts =3D <0x03 0x03>;
> >>>> +                };
> >>>> +
> >>>> +                ep_cmc_firmware_mem_00 {
> >>>> +                        reg =3D <0x00 0x1e20000 0x00 0x20000>;
> >>>> +                        pcie_physical_function =3D <0x00>;
> >>>> +                        compatible =3D "xilinx.com,reg_abs-axi_bram=
_ctrl-1.0\0axi_bram_ctrl";
> >>>> +
> >>>> +                        firmware {
> >>>> +                                firmware_product_name =3D "cmc";
> >>>> +                                firmware_branch_name =3D "u50";
> >>>> +                                firmware_version_major =3D <0x01>;
> >>>> +                                firmware_version_minor =3D <0x00>;
> >>>> +                        };
> >>>> +                };
> >>>> +
> >>>> +                ep_cmc_intc_00 {
> >>>> +                        reg =3D <0x00 0x1e03000 0x00 0x1000>;
> >>>> +                        pcie_physical_function =3D <0x00>;
> >>>> +                        compatible =3D "xilinx.com,reg_abs-axi_intc=
-1.0\0axi_intc";
> >>>> +                        interrupts =3D <0x04 0x04>;
> >>>> +                };
> >>>> +
> >>>> +                ep_cmc_mutex_00 {
> >>>> +                        reg =3D <0x00 0x1e02000 0x00 0x1000>;
> >>>> +                        pcie_physical_function =3D <0x00>;
> >>>> +                        compatible =3D "xilinx.com,reg_abs-axi_gpio=
-1.0\0axi_gpio";
> >>>> +                };
> >>>> +
> >>>> +                ep_cmc_regmap_00 {
> >>>> +                        reg =3D <0x00 0x1e08000 0x00 0x2000>;
> >>>> +                        pcie_physical_function =3D <0x00>;
> >>>> +                        compatible =3D "xilinx.com,reg_abs-axi_bram=
_ctrl-1.0\0axi_bram_ctrl";
> >>>> +
> >>>> +                        firmware {
> >>>> +                                firmware_product_name =3D "sc-fw";
> >>>> +                                firmware_branch_name =3D "u50";
> >>>> +                                firmware_version_major =3D <0x05>;
> >>>> +                        };
> >>>> +                };
> >>>> +
> >>>> +                ep_cmc_reset_00 {
> >>>> +                        reg =3D <0x00 0x1e01000 0x00 0x1000>;
> >>>> +                        pcie_physical_function =3D <0x00>;
> >>>> +                        compatible =3D "xilinx.com,reg_abs-axi_gpio=
-1.0\0axi_gpio";
> >>>> +                };
> >>>> +
> >>>> +                ep_ddr_mem_calib_00 {
> >>>> +                        reg =3D <0x00 0x63000 0x00 0x1000>;
> >>>> +                        pcie_physical_function =3D <0x00>;
> >>>> +                        compatible =3D "xilinx.com,reg_abs-axi_gpio=
-1.0\0axi_gpio";
> >>>> +                };
> >>>> +
> >>>> +                ep_debug_bscan_mgmt_00 {
> >>>> +                        reg =3D <0x00 0x1e90000 0x00 0x10000>;
> >>>> +                        pcie_physical_function =3D <0x00>;
> >>>> +                        compatible =3D "xilinx.com,reg_abs-debug_br=
idge-1.0\0debug_bridge";
> >>>> +                };
> >>>> +
> >>>> +                ep_ert_base_address_00 {
> >>>> +                        reg =3D <0x00 0x21000 0x00 0x1000>;
> >>>> +                        pcie_physical_function =3D <0x00>;
> >>>> +                        compatible =3D "xilinx.com,reg_abs-axi_gpio=
-1.0\0axi_gpio";
> >>>> +                };
> >>>> +
> >>>> +                ep_ert_command_queue_mgmt_00 {
> >>>> +                        reg =3D <0x00 0x40000 0x00 0x10000>;
> >>>> +                        pcie_physical_function =3D <0x00>;
> >>>> +                        compatible =3D "xilinx.com,reg_abs-ert_comm=
and_queue-1.0\0ert_command_queue";
> >>>> +                };
> >>>> +
> >>>> +                ep_ert_command_queue_user_00 {
> >>>> +                        reg =3D <0x00 0x40000 0x00 0x10000>;
> >>>> +                        pcie_physical_function =3D <0x01>;
> >>>> +                        compatible =3D "xilinx.com,reg_abs-ert_comm=
and_queue-1.0\0ert_command_queue";
> >>>> +                };
> >>>> +
> >>>> +                ep_ert_firmware_mem_00 {
> >>>> +                        reg =3D <0x00 0x30000 0x00 0x8000>;
> >>>> +                        pcie_physical_function =3D <0x00>;
> >>>> +                        compatible =3D "xilinx.com,reg_abs-axi_bram=
_ctrl-1.0\0axi_bram_ctrl";
> >>>> +
> >>>> +                        firmware {
> >>>> +                                firmware_product_name =3D "ert";
> >>>> +                                firmware_branch_name =3D "v20";
> >>>> +                                firmware_version_major =3D <0x01>;
> >>>> +                        };
> >>>> +                };
> >>>> +
> >>>> +                ep_ert_intc_00 {
> >>>> +                        reg =3D <0x00 0x23000 0x00 0x1000>;
> >>>> +                        pcie_physical_function =3D <0x00>;
> >>>> +                        compatible =3D "xilinx.com,reg_abs-axi_intc=
-1.0\0axi_intc";
> >>>> +                        interrupts =3D <0x05 0x05>;
> >>>> +                };
> >>>> +
> >>>> +                ep_ert_reset_00 {
> >>>> +                        reg =3D <0x00 0x22000 0x00 0x1000>;
> >>>> +                        pcie_physical_function =3D <0x00>;
> >>>> +                        compatible =3D "xilinx.com,reg_abs-axi_gpio=
-1.0\0axi_gpio";
> >>>> +                };
> >>>> +
> >>>> +                ep_ert_sched_00 {
> >>>> +                        reg =3D <0x00 0x50000 0x00 0x1000>;
> >>>> +                        pcie_physical_function =3D <0x01>;
> >>>> +                        compatible =3D "xilinx.com,reg_abs-ert_sche=
d-1.0\0ert_sched";
> >>>> +                        interrupts =3D <0x09 0x0c>;
> >>>> +                };
> >>>> +
> >>>> +                ep_fpga_configuration_00 {
> >>>> +                        reg =3D <0x00 0x1e88000 0x00 0x8000>;
> >>>> +                        pcie_physical_function =3D <0x00>;
> >>>> +                        compatible =3D "xilinx.com,reg_abs-axi_hwic=
ap-1.0\0axi_hwicap";
> >>>> +                        interrupts =3D <0x02 0x02>;
> >>>> +                };
> >>>> +
> >>>> +                ep_icap_reset_00 {
> >>>> +                        reg =3D <0x00 0x1f07000 0x00 0x1000>;
> >>>> +                        pcie_physical_function =3D <0x00>;
> >>>> +                        compatible =3D "xilinx.com,reg_abs-axi_gpio=
-1.0\0axi_gpio";
> >>>> +                };
> >>>> +
> >>>> +                ep_msix_00 {
> >>>> +                        reg =3D <0x00 0x00 0x00 0x20000>;
> >>>> +                        pcie_physical_function =3D <0x00>;
> >>>> +                        compatible =3D "xilinx.com,reg_abs-msix-1.0=
\0msix";
> >>>> +                        pcie_bar_mapping =3D <0x02>;
> >>>> +                };
> >>>> +
> >>>> +                ep_pcie_link_mon_00 {
> >>>> +                        reg =3D <0x00 0x1f05000 0x00 0x1000>;
> >>>> +                        pcie_physical_function =3D <0x00>;
> >>>> +                        compatible =3D "xilinx.com,reg_abs-axi_gpio=
-1.0\0axi_gpio";
> >>>> +                };
> >>>> +
> >>>> +                ep_pr_isolate_plp_00 {
> >>>> +                        reg =3D <0x00 0x1f01000 0x00 0x1000>;
> >>>> +                        pcie_physical_function =3D <0x00>;
> >>>> +                        compatible =3D "xilinx.com,reg_abs-axi_gpio=
-1.0\0axi_gpio";
> >>>> +                };
> >>>> +
> >>>> +                ep_pr_isolate_ulp_00 {
> >>>> +                        reg =3D <0x00 0x1000 0x00 0x1000>;
> >>>> +                        pcie_physical_function =3D <0x00>;
> >>>> +                        compatible =3D "xilinx.com,reg_abs-axi_gpio=
-1.0\0axi_gpio";
> >>>> +                };
> >>>> +
> >>>> +                ep_uuid_rom_00 {
> >>>> +                        reg =3D <0x00 0x64000 0x00 0x1000>;
> >>>> +                        pcie_physical_function =3D <0x00>;
> >>>> +                        compatible =3D "xilinx.com,reg_abs-axi_bram=
_ctrl-1.0\0axi_bram_ctrl";
> >>>> +                };
> >>>> +
> >>>> +                ep_xdma_00 {
> >>>> +                        reg =3D <0x00 0x00 0x00 0x10000>;
> >>>> +                        pcie_physical_function =3D <0x01>;
> >>>> +                        compatible =3D "xilinx.com,reg_abs-xdma-1.0=
\0xdma";
> >>>> +                        pcie_bar_mapping =3D <0x02>;
> >>>> +                };
> >>>> +        };
> >>>> +
> >>>> +  }
> >>>> +
> >>>> +
> >>>> +
> >>>> +Deployment Models
> >>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>> +
> >>>> +Baremetal
> >>>> +---------
> >>>> +
> >>>> +In bare-metal deployments, both MPF and UPF are visible and accessi=
ble. The
> >>>> +xrt-mgmt driver binds to MPF. The xrt-mgmt driver operations are pr=
ivileged and
> >>>> +available to system administrator. The full stack is illustrated be=
low::
> >>>> +
> >>>> +                            HOST
> >>>> +
> >>>> +               [XRT-MGMT]         [XRT-USER]
> >>>> +                    |                  |
> >>>> +                    |                  |
> >>>> +                 +-----+            +-----+
> >>>> +                 | MPF |            | UPF |
> >>>> +                 |     |            |     |
> >>>> +                 | PF0 |            | PF1 |
> >>>> +                 +--+--+            +--+--+
> >>>> +          ......... ^................. ^..........
> >>>> +                    |                  |
> >>>> +                    |   PCIe DEVICE    |
> >>>> +                    |                  |
> >>>> +                 +--+------------------+--+
> >>>> +                 |         SHELL          |
> >>>> +                 |                        |
> >>>> +                 +------------------------+
> >>>> +                 |         USER           |
> >>>> +                 |                        |
> >>>> +                 |                        |
> >>>> +                 |                        |
> >>>> +                 |                        |
> >>>> +                 +------------------------+
> >>>> +
> >>>> +
> >>>> +
> >>>> +Virtualized
> >>>> +-----------
> >>>> +
> >>>> +In virtualized deployments, the privileged MPF is assigned to the h=
ost but the
> >>>> +unprivileged UPF is assigned to a guest VM via PCIe pass-through. T=
he xrt-mgmt
> >>>> +driver in host binds to MPF. The xrt-mgmt driver operations are pri=
vileged and
> >>>> +only accessible to the MPF. The full stack is illustrated below::
> >>>> +
> >>>> +
> >>>> +                                 ..............
> >>>> +                  HOST           .    VM      .
> >>>> +                                 .            .
> >>>> +               [XRT-MGMT]        . [XRT-USER] .
> >>>> +                    |            .     |      .
> >>>> +                    |            .     |      .
> >>>> +                 +-----+         .  +-----+   .
> >>>> +                 | MPF |         .  | UPF |   .
> >>>> +                 |     |         .  |     |   .
> >>>> +                 | PF0 |         .  | PF1 |   .
> >>>> +                 +--+--+         .  +--+--+   .
> >>>> +          ......... ^................. ^..........
> >>>> +                    |                  |
> >>>> +                    |   PCIe DEVICE    |
> >>>> +                    |                  |
> >>>> +                 +--+------------------+--+
> >>>> +                 |         SHELL          |
> >>>> +                 |                        |
> >>>> +                 +------------------------+
> >>>> +                 |         USER           |
> >>>> +                 |                        |
> >>>> +                 |                        |
> >>>> +                 |                        |
> >>>> +                 |                        |
> >>>> +                 +------------------------+
> >>>> +
> >>>> +
> >>>> +
> >>>> +
> >>>> +
> >>>> +Platform Security Considerations
> >>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>> +
> >>>> +`Security of Alveo Platform <https://xilinx.github.io/XRT/master/ht=
ml/security.html>`_
> >>>> +discusses the deployment options and security implications in great=
 detail.
> >>>> diff --git a/MAINTAINERS b/MAINTAINERS
> >>>> index 056966c9aac9..beeaf0257364 100644
> >>>> --- a/MAINTAINERS
> >>>> +++ b/MAINTAINERS
> >>>> @@ -7274,6 +7274,17 @@ F:     Documentation/fpga/
> >>>>    F:   drivers/fpga/
> >>>>    F:   include/linux/fpga/
> >>>>
> >>>> +FPGA XRT DRIVERS
> >>>> +M:   Lizhi Hou <lizhi.hou@xilinx.com>
> >>>> +R:   Max Zhen <max.zhen@xilinx.com>
> >>>> +R:   Sonal Santan <sonal.santan@xilinx.com>
> >>>> +L:   linux-fpga@vger.kernel.org
> >>>> +S:   Supported
> >>>> +W:   https://github.com/Xilinx/XRT
> >>>> +F:   Documentation/fpga/xrt.rst
> >>>> +F:   drivers/fpga/xrt/
> >>>> +F:   include/uapi/linux/xrt/
> >>>> +
> >>>>    FPU EMULATOR
> >>>>    M:   Bill Metzenthen <billm@melbpc.org.au>
> >>>>    S:   Maintained
> >>>> --
> >>>> 2.27.0
