Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9502445B718
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 10:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbhKXJHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 04:07:53 -0500
Received: from mga04.intel.com ([192.55.52.120]:36204 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229829AbhKXJHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 04:07:51 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="233959734"
X-IronPort-AV: E=Sophos;i="5.87,260,1631602800"; 
   d="scan'208";a="233959734"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 01:04:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,260,1631602800"; 
   d="scan'208";a="475049785"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 24 Nov 2021 01:04:40 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mpoCl-0004ZY-Nh; Wed, 24 Nov 2021 09:04:39 +0000
Date:   Wed, 24 Nov 2021 17:03:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [l1k:sitara_rs485 3/3] drivers/tty/serial/8250/8250_omap.c:1456:40:
 error: incompatible type for argument 1 of 'serial_in'
Message-ID: <202111241755.r6MGaKd2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/l1k/linux sitara_rs485
head:   43b861e5610ae33d3f6ee06a63a4e3ee3f37d3b3
commit: 43b861e5610ae33d3f6ee06a63a4e3ee3f37d3b3 [3/3] serial: 8250: 8250_omap: Support native rs485
config: arc-randconfig-r043-20211124 (https://download.01.org/0day-ci/archive/20211124/202111241755.r6MGaKd2-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/l1k/linux/commit/43b861e5610ae33d3f6ee06a63a4e3ee3f37d3b3
        git remote add l1k https://github.com/l1k/linux
        git fetch --no-tags l1k sitara_rs485
        git checkout 43b861e5610ae33d3f6ee06a63a4e3ee3f37d3b3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/tty/serial/8250/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/tty/serial/8250/8250_omap.c: In function 'omap8250_probe':
>> drivers/tty/serial/8250/8250_omap.c:1456:40: error: incompatible type for argument 1 of 'serial_in'
    1456 |                 priv->mdr3 = serial_in(up, UART_OMAP_MDR3);
         |                                        ^~
         |                                        |
         |                                        struct uart_8250_port
   In file included from drivers/tty/serial/8250/8250_omap.c:32:
   drivers/tty/serial/8250/8250.h:113:52: note: expected 'struct uart_8250_port *' but argument is of type 'struct uart_8250_port'
     113 | static inline int serial_in(struct uart_8250_port *up, int offset)
         |                             ~~~~~~~~~~~~~~~~~~~~~~~^~


vim +/serial_in +1456 drivers/tty/serial/8250/8250_omap.c

  1347	
  1348	static int omap8250_probe(struct platform_device *pdev)
  1349	{
  1350		struct device_node *np = pdev->dev.of_node;
  1351		struct omap8250_priv *priv;
  1352		const struct omap8250_platdata *pdata;
  1353		struct uart_8250_port up;
  1354		struct resource *regs;
  1355		void __iomem *membase;
  1356		int irq, ret;
  1357	
  1358		irq = platform_get_irq(pdev, 0);
  1359		if (irq < 0)
  1360			return irq;
  1361	
  1362		regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
  1363		if (!regs) {
  1364			dev_err(&pdev->dev, "missing registers\n");
  1365			return -EINVAL;
  1366		}
  1367	
  1368		priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
  1369		if (!priv)
  1370			return -ENOMEM;
  1371	
  1372		membase = devm_ioremap(&pdev->dev, regs->start,
  1373					       resource_size(regs));
  1374		if (!membase)
  1375			return -ENODEV;
  1376	
  1377		memset(&up, 0, sizeof(up));
  1378		up.port.dev = &pdev->dev;
  1379		up.port.mapbase = regs->start;
  1380		up.port.membase = membase;
  1381		up.port.irq = irq;
  1382		/*
  1383		 * It claims to be 16C750 compatible however it is a little different.
  1384		 * It has EFR and has no FCR7_64byte bit. The AFE (which it claims to
  1385		 * have) is enabled via EFR instead of MCR. The type is set here 8250
  1386		 * just to get things going. UNKNOWN does not work for a few reasons and
  1387		 * we don't need our own type since we don't use 8250's set_termios()
  1388		 * or pm callback.
  1389		 */
  1390		up.port.type = PORT_8250;
  1391		up.port.iotype = UPIO_MEM;
  1392		up.port.flags = UPF_FIXED_PORT | UPF_FIXED_TYPE | UPF_SOFT_FLOW |
  1393			UPF_HARD_FLOW;
  1394		up.port.private_data = priv;
  1395	
  1396		up.port.regshift = 2;
  1397		up.port.fifosize = 64;
  1398		up.tx_loadsz = 64;
  1399		up.capabilities = UART_CAP_FIFO;
  1400	#ifdef CONFIG_PM
  1401		/*
  1402		 * Runtime PM is mostly transparent. However to do it right we need to a
  1403		 * TX empty interrupt before we can put the device to auto idle. So if
  1404		 * PM is not enabled we don't add that flag and can spare that one extra
  1405		 * interrupt in the TX path.
  1406		 */
  1407		up.capabilities |= UART_CAP_RPM;
  1408	#endif
  1409		up.port.set_termios = omap_8250_set_termios;
  1410		up.port.set_mctrl = omap8250_set_mctrl;
  1411		up.port.pm = omap_8250_pm;
  1412		up.port.startup = omap_8250_startup;
  1413		up.port.shutdown = omap_8250_shutdown;
  1414		up.port.throttle = omap_8250_throttle;
  1415		up.port.unthrottle = omap_8250_unthrottle;
  1416		up.port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
  1417	
  1418		ret = of_alias_get_id(np, "serial");
  1419		if (ret < 0) {
  1420			dev_err(&pdev->dev, "failed to get alias\n");
  1421			return ret;
  1422		}
  1423		up.port.line = ret;
  1424	
  1425		if (of_property_read_u32(np, "clock-frequency", &up.port.uartclk)) {
  1426			struct clk *clk;
  1427	
  1428			clk = devm_clk_get(&pdev->dev, NULL);
  1429			if (IS_ERR(clk)) {
  1430				if (PTR_ERR(clk) == -EPROBE_DEFER)
  1431					return -EPROBE_DEFER;
  1432			} else {
  1433				up.port.uartclk = clk_get_rate(clk);
  1434			}
  1435		}
  1436	
  1437		if (of_property_read_u32(np, "overrun-throttle-ms",
  1438					 &up.overrun_backoff_time_ms) != 0)
  1439			up.overrun_backoff_time_ms = 0;
  1440	
  1441		priv->wakeirq = irq_of_parse_and_map(np, 1);
  1442	
  1443		pdata = of_device_get_match_data(&pdev->dev);
  1444		if (pdata)
  1445			priv->habit |= pdata->habit;
  1446	
  1447		if (!up.port.uartclk) {
  1448			up.port.uartclk = DEFAULT_CLK_SPEED;
  1449			dev_warn(&pdev->dev,
  1450				 "No clock speed specified: using default: %d\n",
  1451				 DEFAULT_CLK_SPEED);
  1452		}
  1453	
  1454		if (priv->habit & UART_HAS_NATIVE_RS485) {
  1455			up.port.rs485_config = omap8250_rs485_config;
> 1456			priv->mdr3 = serial_in(up, UART_OMAP_MDR3);
  1457		} else {
  1458			up.port.rs485_config = serial8250_em485_config;
  1459			up.rs485_start_tx = serial8250_em485_start_tx;
  1460			up.rs485_stop_tx = serial8250_em485_stop_tx;
  1461		}
  1462	
  1463		priv->latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
  1464		priv->calc_latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
  1465		cpu_latency_qos_add_request(&priv->pm_qos_request, priv->latency);
  1466		INIT_WORK(&priv->qos_work, omap8250_uart_qos_work);
  1467	
  1468		spin_lock_init(&priv->rx_dma_lock);
  1469	
  1470		device_init_wakeup(&pdev->dev, true);
  1471		pm_runtime_enable(&pdev->dev);
  1472		pm_runtime_use_autosuspend(&pdev->dev);
  1473	
  1474		/*
  1475		 * Disable runtime PM until autosuspend delay unless specifically
  1476		 * enabled by the user via sysfs. This is the historic way to
  1477		 * prevent an unsafe default policy with lossy characters on wake-up.
  1478		 * For serdev devices this is not needed, the policy can be managed by
  1479		 * the serdev driver.
  1480		 */
  1481		if (!of_get_available_child_count(pdev->dev.of_node))
  1482			pm_runtime_set_autosuspend_delay(&pdev->dev, -1);
  1483	
  1484		pm_runtime_irq_safe(&pdev->dev);
  1485	
  1486		pm_runtime_get_sync(&pdev->dev);
  1487	
  1488		omap_serial_fill_features_erratas(&up, priv);
  1489		up.port.handle_irq = omap8250_no_handle_irq;
  1490		priv->rx_trigger = RX_TRIGGER;
  1491		priv->tx_trigger = TX_TRIGGER;
  1492	#ifdef CONFIG_SERIAL_8250_DMA
  1493		/*
  1494		 * Oh DMA support. If there are no DMA properties in the DT then
  1495		 * we will fall back to a generic DMA channel which does not
  1496		 * really work here. To ensure that we do not get a generic DMA
  1497		 * channel assigned, we have the the_no_dma_filter_fn() here.
  1498		 * To avoid "failed to request DMA" messages we check for DMA
  1499		 * properties in DT.
  1500		 */
  1501		ret = of_property_count_strings(np, "dma-names");
  1502		if (ret == 2) {
  1503			struct omap8250_dma_params *dma_params = NULL;
  1504	
  1505			up.dma = &priv->omap8250_dma;
  1506			up.dma->fn = the_no_dma_filter_fn;
  1507			up.dma->tx_dma = omap_8250_tx_dma;
  1508			up.dma->rx_dma = omap_8250_rx_dma;
  1509			if (pdata)
  1510				dma_params = pdata->dma_params;
  1511	
  1512			if (dma_params) {
  1513				up.dma->rx_size = dma_params->rx_size;
  1514				up.dma->rxconf.src_maxburst = dma_params->rx_trigger;
  1515				up.dma->txconf.dst_maxburst = dma_params->tx_trigger;
  1516				priv->rx_trigger = dma_params->rx_trigger;
  1517				priv->tx_trigger = dma_params->tx_trigger;
  1518			} else {
  1519				up.dma->rx_size = RX_TRIGGER;
  1520				up.dma->rxconf.src_maxburst = RX_TRIGGER;
  1521				up.dma->txconf.dst_maxburst = TX_TRIGGER;
  1522			}
  1523		}
  1524	#endif
  1525		ret = serial8250_register_8250_port(&up);
  1526		if (ret < 0) {
  1527			dev_err(&pdev->dev, "unable to register 8250 port\n");
  1528			goto err;
  1529		}
  1530		priv->line = ret;
  1531		platform_set_drvdata(pdev, priv);
  1532		pm_runtime_mark_last_busy(&pdev->dev);
  1533		pm_runtime_put_autosuspend(&pdev->dev);
  1534		return 0;
  1535	err:
  1536		pm_runtime_dont_use_autosuspend(&pdev->dev);
  1537		pm_runtime_put_sync(&pdev->dev);
  1538		pm_runtime_disable(&pdev->dev);
  1539		return ret;
  1540	}
  1541	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
